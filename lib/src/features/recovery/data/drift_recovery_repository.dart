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
  Stream<List<RecoveryHistoryEntry>> watchRecoveryHistory({int days = 30}) {
    final startDayKey = _startDate(days).dayKey;
    return (_database.select(_database.recoveryDayEntries)
          ..where((tbl) =>
              tbl.dayKey.isBiggerOrEqualValue(startDayKey) &
              tbl.status.equals(RecoveryDayStatus.recovery.name))
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.dayKey),
          ]))
        .watch()
        .map(
          (rows) => rows.map(_mapRecoveryHistoryEntry).toList(),
        );
  }

  @override
  Stream<WeeklyRecoveryReview> watchWeeklyReview({int days = 7}) {
    final startDayKey = _startDate(days).dayKey;
    return (_database.select(_database.recoveryDayEntries)
          ..where((tbl) => tbl.dayKey.isBiggerOrEqualValue(startDayKey)))
        .watch()
        .asyncMap((_) => _buildWeeklyReview(days));
  }

  @override
  Stream<RecoveryInsight> watchDifficultPeriodInsight({int days = 14}) {
    final startDayKey = _startDate(days).dayKey;
    return (_database.select(_database.recoveryDayEntries)
          ..where((tbl) =>
              tbl.dayKey.isBiggerOrEqualValue(startDayKey) &
              (tbl.status.equals(RecoveryDayStatus.tense.name) |
                  tbl.status.equals(RecoveryDayStatus.recovery.name))))
        .watch()
        .asyncMap((_) => _buildDifficultPeriodInsight(days));
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
    final now = DateTime.now();
    final today = now.dateOnly;
    final dayKey = today.dayKey;

    await _database.into(_database.dailyCheckIns).insertOnConflictUpdate(
          DailyCheckInsCompanion(
            dayKey: Value(dayKey),
            energy: Value(draft.energy.dbValue),
            load: Value(draft.load.dbValue),
            mood: Value(draft.mood.dbValue),
            createdAt: Value(now),
          ),
        );

    final existingEntry = await (_database.select(_database.recoveryDayEntries)
          ..where((tbl) => tbl.dayKey.equals(dayKey)))
        .getSingleOrNull();

    final evaluation = await _evaluateDay(today, draft);
    final preserveAccepted =
        existingEntry?.lightPlanAccepted == true &&
        evaluation.status == RecoveryDayStatus.recovery;

    await _database.into(_database.recoveryDayEntries).insertOnConflictUpdate(
          RecoveryDayEntriesCompanion(
            dayKey: Value(dayKey),
            status: Value(evaluation.status.name),
            riskScore: Value(evaluation.riskScore),
            reasons: Value(_encodeReasons(evaluation.reasons)),
            suggestedHabitIds: Value(
              _encodeIds(evaluation.suggestedHabitIds),
            ),
            lightPlanAccepted: Value(preserveAccepted),
            lightPlanAcceptedAt: Value(
              preserveAccepted ? existingEntry?.lightPlanAcceptedAt : null,
            ),
            createdAt: Value(existingEntry?.createdAt ?? now),
          ),
        );
  }

  @override
  Future<void> acceptLightPlan(String dayKey) {
    return (_database.update(_database.recoveryDayEntries)
          ..where((tbl) => tbl.dayKey.equals(dayKey)))
        .write(
          RecoveryDayEntriesCompanion(
            lightPlanAccepted: const Value(true),
            lightPlanAcceptedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<WeeklyRecoveryReview> _buildWeeklyReview(int days) async {
    final entries = await _loadRecentEntries(days: days);
    if (entries.isEmpty) {
      return const WeeklyRecoveryReview.empty();
    }

    var normalDays = 0;
    var tenseDays = 0;
    var recoveryDays = 0;
    var recoveryPlanned = 0;
    var recoveryCompleted = 0;
    var regularPlanned = 0;
    var regularCompleted = 0;

    for (final entry in entries) {
      switch (RecoveryDayStatus.values.byName(entry.status)) {
        case RecoveryDayStatus.normal:
          normalDays += 1;
        case RecoveryDayStatus.tense:
          tenseDays += 1;
        case RecoveryDayStatus.recovery:
          recoveryDays += 1;
      }

      final metrics = await _loadDayCompletionMetrics(_dateFromDayKey(entry.dayKey));
      if (entry.status == RecoveryDayStatus.recovery.name) {
        recoveryPlanned += metrics.plannedCount;
        recoveryCompleted += metrics.completedCount;
      } else {
        regularPlanned += metrics.plannedCount;
        regularCompleted += metrics.completedCount;
      }
    }

    return WeeklyRecoveryReview(
      normalDays: normalDays,
      tenseDays: tenseDays,
      recoveryDays: recoveryDays,
      recoveryCompletionRate: _safeRate(
        completed: recoveryCompleted,
        planned: recoveryPlanned,
      ),
      regularCompletionRate: _safeRate(
        completed: regularCompleted,
        planned: regularPlanned,
      ),
    );
  }

  Future<RecoveryInsight> _buildDifficultPeriodInsight(int days) async {
    final entries = await _loadRecentEntries(
      days: days,
      statuses: {
        RecoveryDayStatus.tense.name,
        RecoveryDayStatus.recovery.name,
      },
    );
    if (entries.length < 2) {
      return const RecoveryInsight.empty();
    }

    final reasonCounts = <String, int>{};
    var plannedTotal = 0;
    var completedTotal = 0;

    for (final entry in entries) {
      for (final reason in _decodeReasons(entry.reasons)) {
        reasonCounts.update(reason, (value) => value + 1, ifAbsent: () => 1);
      }
      final metrics = await _loadDayCompletionMetrics(_dateFromDayKey(entry.dayKey));
      plannedTotal += metrics.plannedCount;
      completedTotal += metrics.completedCount;
    }

    final explanations = reasonCounts.entries.toList()
      ..sort((left, right) {
        final countCompare = right.value.compareTo(left.value);
        if (countCompare != 0) {
          return countCompare;
        }
        return left.key.compareTo(right.key);
      });

    final topReasons = explanations
        .take(3)
        .map((entry) => '${entry.key} Повторялось ${entry.value} ${_timesLabel(entry.value)}.')
        .toList();

    final completionRate = _safeRate(
      completed: completedTotal,
      planned: plannedTotal,
    );
    if (plannedTotal > 0 && completionRate < 0.6) {
      topReasons.add(
        'В сложные дни выполнение привычек снижалось до '
        '${(completionRate * 100).round()}% от плана.',
      );
    }

    if (topReasons.isEmpty) {
      return const RecoveryInsight.empty();
    }

    return RecoveryInsight(
      summary: 'За последние $days дней заметны повторяющиеся сигналы сложного периода.',
      explanations: topReasons.take(3).toList(),
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

  Future<List<RecoveryDayEntry>> _loadRecentEntries({
    required int days,
    Set<String>? statuses,
  }) async {
    final startDayKey = _startDate(days).dayKey;
    final query = _database.select(_database.recoveryDayEntries)
      ..where((tbl) => tbl.dayKey.isBiggerOrEqualValue(startDayKey))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.dayKey)]);

    if (statuses != null && statuses.isNotEmpty) {
      query.where((tbl) => tbl.status.isIn(statuses.toList()));
    }

    return query.get();
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

  Future<_DayCompletionMetrics> _loadDayCompletionMetrics(DateTime day) async {
    final plannedHabitIds = await _loadPlannedHabitIdsForDay(day);
    if (plannedHabitIds.isEmpty) {
      return const _DayCompletionMetrics(plannedCount: 0, completedCount: 0);
    }

    final completedCount = await (_database.select(_database.habitCompletions)
          ..where((tbl) =>
              tbl.dayKey.equals(day.dayKey) & tbl.habitId.isIn(plannedHabitIds)))
        .get()
        .then((rows) => rows.length);

    return _DayCompletionMetrics(
      plannedCount: plannedHabitIds.length,
      completedCount: completedCount,
    );
  }

  Future<List<int>> _loadPlannedHabitIdsForDay(DateTime day) async {
    final rows = await (_database.select(_database.habits).join([
      innerJoin(
        _database.habitSchedules,
        _database.habitSchedules.habitId.equalsExp(_database.habits.id),
      ),
    ])
          ..where(_database.habits.isArchived.equals(false)))
        .get();

    return rows
        .where((row) {
          final schedule = row.readTable(_database.habitSchedules);
          return parseWeekdays(schedule.weekdays).contains(day.weekday);
        })
        .map((row) => row.readTable(_database.habits).id)
        .toList();
  }

  RecoveryDayState _mapRecoveryState(RecoveryDayEntry entry) {
    return RecoveryDayState(
      dayKey: entry.dayKey,
      status: RecoveryDayStatus.values.byName(entry.status),
      riskScore: entry.riskScore,
      reasons: _decodeReasons(entry.reasons),
      suggestedHabitIds: _decodeIds(entry.suggestedHabitIds),
      lightPlanAccepted: entry.lightPlanAccepted,
      lightPlanAcceptedAt: entry.lightPlanAcceptedAt,
      createdAt: entry.createdAt,
    );
  }

  RecoveryHistoryEntry _mapRecoveryHistoryEntry(RecoveryDayEntry entry) {
    return RecoveryHistoryEntry(
      dayKey: entry.dayKey,
      date: _dateFromDayKey(entry.dayKey),
      status: RecoveryDayStatus.values.byName(entry.status),
      reasons: _decodeReasons(entry.reasons),
      suggestedHabitIds: _decodeIds(entry.suggestedHabitIds),
      lightPlanAccepted: entry.lightPlanAccepted,
      lightPlanAcceptedAt: entry.lightPlanAcceptedAt,
      createdAt: entry.createdAt,
    );
  }

  DateTime _startDate(int days) {
    final today = DateTime.now().dateOnly;
    return today.subtract(Duration(days: days - 1));
  }

  DateTime _dateFromDayKey(String dayKey) {
    final parts = dayKey.split('-').map(int.parse).toList();
    return DateTime(parts[0], parts[1], parts[2]);
  }

  double _safeRate({
    required int completed,
    required int planned,
  }) {
    if (planned == 0) {
      return 0;
    }
    return completed / planned;
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

  String _timesLabel(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return 'раз';
    }
    if ([2, 3, 4].contains(count % 10) &&
        ![12, 13, 14].contains(count % 100)) {
      return 'раза';
    }
    return 'раз';
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

class _DayCompletionMetrics {
  const _DayCompletionMetrics({
    required this.plannedCount,
    required this.completedCount,
  });

  final int plannedCount;
  final int completedCount;
}
