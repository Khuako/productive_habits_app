import 'package:drift/drift.dart';

import '../../../core/utils/date_utils.dart';
import '../../../data/local/app_database.dart';
import '../../recovery/domain/recovery_models.dart';
import '../../recovery/domain/recovery_repository.dart';
import '../../recovery/domain/recovery_rule_engine.dart';

class DriftRecoveryRepository implements RecoveryRepository {
  DriftRecoveryRepository({
    required AppDatabase database,
    required RecoveryRuleEngine ruleEngine,
  })  : _database = database,
        _ruleEngine = ruleEngine;

  final AppDatabase _database;
  final RecoveryRuleEngine _ruleEngine;

  @override
  Stream<RecoveryDayState?> watchTodayState() {
    final dayKey = DateTime.now().dayKey;
    return (_database.select(_database.recoveryDayEntries)
          ..where((tbl) => tbl.dayKey.equals(dayKey)))
        .watchSingleOrNull()
        .map((entry) => entry == null ? null : _mapRecoveryState(entry));
  }

  @override
  Future<RecoveryDayState?> getTodayState() async {
    final entry = await (_database.select(_database.recoveryDayEntries)
          ..where((tbl) => tbl.dayKey.equals(DateTime.now().dayKey)))
        .getSingleOrNull();
    return entry == null ? null : _mapRecoveryState(entry);
  }

  @override
  Future<void> submitDailyCheckIn(DailyCheckInDraft draft) async {
    final today = DateTime.now().dateOnly;
    final dayKey = today.dayKey;

    await _database.into(_database.dailyCheckIns).insertOnConflictUpdate(
          DailyCheckInsCompanion(
            dayKey: Value(dayKey),
            energy: Value(draft.energy.dbValue),
            load: Value(draft.load.dbValue),
            mood: Value(draft.mood.dbValue),
            createdAt: Value(DateTime.now()),
          ),
        );

    final evaluation = await _evaluateDay(today, draft);
    await _database.into(_database.recoveryDayEntries).insertOnConflictUpdate(
          RecoveryDayEntriesCompanion(
            dayKey: Value(dayKey),
            status: Value(evaluation.status.name),
            riskScore: Value(evaluation.riskScore),
            reasons: Value(_encodeReasons(evaluation.reasons)),
            suggestedHabitIds: Value(
              _encodeIds(evaluation.suggestedHabitIds),
            ),
            createdAt: Value(DateTime.now()),
          ),
        );
  }

  Future<_ComputedRecoveryDay> _evaluateDay(
    DateTime day,
    DailyCheckInDraft draft,
  ) async {
    final plannedHabits = await _loadTodayHabitCandidates(day);
    final currentStreak = await _loadCurrentStreak();
    final recentMissedDays = await _countRecentMissedDays(day);

    final evaluation = _ruleEngine.evaluate(
      RecoveryEvaluationInput(
        energy: draft.energy,
        load: draft.load,
        mood: draft.mood,
        plannedHabitsCount: plannedHabits.length,
        currentStreak: currentStreak,
        recentMissedDays: recentMissedDays,
      ),
    );

    final suggestedHabitIds = evaluation.status == RecoveryDayStatus.recovery
        ? (plannedHabits.toList()
              ..sort((left, right) {
                final priorityCompare = right.priority.compareTo(left.priority);
                if (priorityCompare != 0) {
                  return priorityCompare;
                }
                final difficultyCompare =
                    right.difficulty.compareTo(left.difficulty);
                if (difficultyCompare != 0) {
                  return difficultyCompare;
                }
                return left.id.compareTo(right.id);
              }))
            .take(3)
            .map((habit) => habit.id)
            .toList()
        : const <int>[];

    return _ComputedRecoveryDay(
      status: evaluation.status,
      riskScore: evaluation.riskScore,
      reasons: evaluation.reasons,
      suggestedHabitIds: suggestedHabitIds,
    );
  }

  Future<int> _loadCurrentStreak() async {
    final entry = await (_database.select(_database.userProgressEntries)
          ..where((tbl) => tbl.id.equals(1)))
        .getSingleOrNull();
    return entry?.currentStreak ?? 0;
  }

  Future<int> _countRecentMissedDays(DateTime today) async {
    var missedDays = 0;
    for (var offset = 1; offset <= 2; offset++) {
      final date = today.subtract(Duration(days: offset));
      final candidates = await _loadTodayHabitCandidates(date);
      if (candidates.isEmpty) {
        continue;
      }

      final completedCount = await (_database.select(_database.habitCompletions)
            ..where((tbl) => tbl.dayKey.equals(date.dayKey)))
          .get()
          .then((rows) => rows.length);

      if (completedCount < candidates.length) {
        missedDays += 1;
      }
    }
    return missedDays;
  }

  Future<List<_HabitPriorityCandidate>> _loadTodayHabitCandidates(
    DateTime day,
  ) async {
    final rows = await (_database.select(_database.habits).join([
      innerJoin(
        _database.habitSchedules,
        _database.habitSchedules.habitId.equalsExp(_database.habits.id),
      ),
      leftOuterJoin(
        _database.habitCompletions,
        _database.habitCompletions.habitId.equalsExp(_database.habits.id) &
            _database.habitCompletions.dayKey.equals(day.dayKey),
      ),
    ])
          ..where(_database.habits.isArchived.equals(false)))
        .get();

    return rows
        .map((row) {
          final habit = row.readTable(_database.habits);
          final schedule = row.readTable(_database.habitSchedules);
          final completion = row.readTableOrNull(_database.habitCompletions);

          final weekdays = parseWeekdays(schedule.weekdays);
          final scheduledToday = weekdays.contains(day.weekday);
          if (!scheduledToday || completion != null) {
            return null;
          }

          return _HabitPriorityCandidate(
            id: habit.id,
            priority: habit.priority,
            difficulty: habit.difficulty,
          );
        })
        .whereType<_HabitPriorityCandidate>()
        .toList();
  }

  RecoveryDayState _mapRecoveryState(RecoveryDayEntry entry) {
    return RecoveryDayState(
      dayKey: entry.dayKey,
      status: RecoveryDayStatus.values.byName(entry.status),
      riskScore: entry.riskScore,
      reasons: _decodeReasons(entry.reasons),
      suggestedHabitIds: _decodeIds(entry.suggestedHabitIds),
      createdAt: entry.createdAt,
    );
  }

  String _encodeReasons(List<String> reasons) => reasons.join('||');

  List<String> _decodeReasons(String raw) {
    if (raw.trim().isEmpty) {
      return const [];
    }
    return raw.split('||').where((item) => item.trim().isNotEmpty).toList();
  }

  String _encodeIds(List<int> ids) => ids.join(',');

  List<int> _decodeIds(String raw) {
    if (raw.trim().isEmpty) {
      return const [];
    }
    return raw
        .split(',')
        .where((item) => item.trim().isNotEmpty)
        .map(int.parse)
        .toList();
  }
}

class _ComputedRecoveryDay {
  const _ComputedRecoveryDay({
    required this.status,
    required this.riskScore,
    required this.reasons,
    required this.suggestedHabitIds,
  });

  final RecoveryDayStatus status;
  final int riskScore;
  final List<String> reasons;
  final List<int> suggestedHabitIds;
}

class _HabitPriorityCandidate {
  const _HabitPriorityCandidate({
    required this.id,
    required this.priority,
    required this.difficulty,
  });

  final int id;
  final int priority;
  final int difficulty;
}
