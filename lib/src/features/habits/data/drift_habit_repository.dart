import 'package:drift/drift.dart';

import '../../../core/services/reminder_service.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/local/app_database.dart' hide Habit, HabitSchedule;
import '../../profile/domain/progress_repository.dart';
import '../domain/habit_models.dart';
import '../domain/habit_repository.dart';

class DriftHabitRepository implements HabitRepository {
  DriftHabitRepository({
    required AppDatabase database,
    required ProgressRepository progressRepository,
    required ReminderService reminderService,
  })  : _database = database,
        _progressRepository = progressRepository,
        _reminderService = reminderService;

  final AppDatabase _database;
  final ProgressRepository _progressRepository;
  final ReminderService _reminderService;

  @override
  Stream<List<HabitItem>> watchAllHabits({DateTime? forDay}) {
    final selectedDay = (forDay ?? DateTime.now()).dateOnly;
    final joinedQuery = _buildJoinedQuery(selectedDay.dayKey);
    return joinedQuery.watch().map(
          (rows) => rows
              .map((row) => _mapHabitItem(row, selectedDay))
              .toList()
            ..sort(_sortHabitItems),
        );
  }

  @override
  Stream<List<HabitItem>> watchTodayHabits({DateTime? day}) {
    final selectedDay = (day ?? DateTime.now()).dateOnly;
    return watchAllHabits(forDay: selectedDay).map(
      (items) => items.where((item) => item.scheduledToday).toList(),
    );
  }

  @override
  Future<Habit?> getHabitById(int id) async {
    final query = _database.select(_database.habits).join([
      innerJoin(
        _database.habitSchedules,
        _database.habitSchedules.habitId.equalsExp(_database.habits.id),
      ),
    ])
      ..where(_database.habits.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }
    return _mapHabit(row);
  }

  @override
  Future<int> createHabit(HabitDraft draft) async {
    final normalized = draft.withVisualDefaults();
    final habitId = await _database.into(_database.habits).insert(
          HabitsCompanion.insert(
            title: normalized.title,
            description: Value(normalized.description),
            category: normalized.category,
            difficulty: normalized.difficulty,
            priority: Value(normalized.priority),
            iconName: normalized.iconName!,
            colorValue: normalized.colorValue!,
            xpReward: normalized.xpReward!,
          ),
        );

    await _database.into(_database.habitSchedules).insert(
          HabitSchedulesCompanion.insert(
            habitId: habitId,
            weekdays: encodeWeekdays(normalized.schedule.weekdays),
            reminderEnabled: Value(normalized.schedule.reminderEnabled),
            reminderHour: Value(normalized.schedule.reminderHour),
            reminderMinute: Value(normalized.schedule.reminderMinute),
          ),
        );

    final habit = await getHabitById(habitId);
    if (habit != null) {
      await _reminderService.syncHabitReminder(habit);
    }
    await _progressRepository.refreshDerivedState();
    return habitId;
  }

  @override
  Future<void> updateHabit(int id, HabitDraft draft) async {
    final normalized = draft.withVisualDefaults();
    await (_database.update(_database.habits)..where((tbl) => tbl.id.equals(id))).write(
      HabitsCompanion(
        title: Value(normalized.title),
        description: Value(normalized.description),
        category: Value(normalized.category),
        difficulty: Value(normalized.difficulty),
        priority: Value(normalized.priority),
        iconName: Value(normalized.iconName!),
        colorValue: Value(normalized.colorValue!),
        xpReward: Value(normalized.xpReward!),
      ),
    );

    await (_database.update(_database.habitSchedules)
          ..where((tbl) => tbl.habitId.equals(id)))
        .write(
      HabitSchedulesCompanion(
        weekdays: Value(encodeWeekdays(normalized.schedule.weekdays)),
        reminderEnabled: Value(normalized.schedule.reminderEnabled),
        reminderHour: Value(normalized.schedule.reminderHour),
        reminderMinute: Value(normalized.schedule.reminderMinute),
      ),
    );

    final habit = await getHabitById(id);
    if (habit != null) {
      await _reminderService.syncHabitReminder(habit);
    }
    await _progressRepository.refreshDerivedState();
  }

  @override
  Future<void> archiveHabit(int id) async {
    await (_database.update(_database.habits)..where((tbl) => tbl.id.equals(id))).write(
      const HabitsCompanion(
        isArchived: Value(true),
      ),
    );
    await _reminderService.cancelHabitReminder(id);
    await _progressRepository.refreshDerivedState();
  }

  @override
  Future<void> toggleCompletion(int habitId, {DateTime? onDay}) async {
    final date = (onDay ?? DateTime.now()).dateOnly;
    final existing = await (_database.select(_database.habitCompletions)
          ..where((tbl) =>
              tbl.habitId.equals(habitId) & tbl.dayKey.equals(date.dayKey)))
        .getSingleOrNull();

    if (existing != null) {
      await (_database.delete(_database.habitCompletions)
            ..where((tbl) => tbl.id.equals(existing.id)))
          .go();
      await _progressRepository.refreshDerivedState();
      return;
    }

    final habit = await getHabitById(habitId);
    if (habit == null) {
      return;
    }

    await _database.into(_database.habitCompletions).insert(
          HabitCompletionsCompanion.insert(
            habitId: habitId,
            dayKey: date.dayKey,
            completedAt: DateTime.now(),
            awardedXp: habit.xpReward,
            streakAfterCompletion: const Value(0),
          ),
        );
    await _progressRepository.refreshDerivedState();
  }

  @override
  Future<void> addTemplates(List<HabitTemplate> templates) async {
    for (final template in templates) {
      await createHabit(template.toDraft());
    }
    await _progressRepository.refreshDerivedState();
  }

  @override
  Future<void> syncAllReminders() async {
    final habits = await _allActiveHabits();
    await _reminderService.syncAllHabitReminders(habits);
  }

  JoinedSelectStatement<HasResultSet, dynamic> _buildJoinedQuery(String dayKey) {
    return _database.select(_database.habits).join([
      innerJoin(
        _database.habitSchedules,
        _database.habitSchedules.habitId.equalsExp(_database.habits.id),
      ),
      leftOuterJoin(
        _database.habitCompletions,
        _database.habitCompletions.habitId.equalsExp(_database.habits.id) &
            _database.habitCompletions.dayKey.equals(dayKey),
      ),
    ])
      ..where(_database.habits.isArchived.equals(false));
  }

  Habit _mapHabit(TypedResult row) {
    final habitRow = row.readTable(_database.habits);
    final scheduleRow = row.readTable(_database.habitSchedules);

    return Habit(
      id: habitRow.id,
      title: habitRow.title,
      description: habitRow.description,
      category: habitRow.category,
      difficulty: habitRow.difficulty,
      priority: habitRow.priority,
      iconName: habitRow.iconName,
      colorValue: habitRow.colorValue,
      xpReward: habitRow.xpReward,
      createdAt: habitRow.createdAt,
      isArchived: habitRow.isArchived,
      schedule: HabitSchedule(
        weekdays: parseWeekdays(scheduleRow.weekdays),
        reminderEnabled: scheduleRow.reminderEnabled,
        reminderHour: scheduleRow.reminderHour,
        reminderMinute: scheduleRow.reminderMinute,
      ),
    );
  }

  HabitItem _mapHabitItem(TypedResult row, DateTime selectedDay) {
    final completionRow = row.readTableOrNull(_database.habitCompletions);
    final habit = _mapHabit(row);

    return HabitItem(
      habit: habit,
      completedToday: completionRow != null,
      scheduledToday: habit.schedule.isScheduledFor(selectedDay),
      completedAt: completionRow?.completedAt,
    );
  }

  int _sortHabitItems(HabitItem left, HabitItem right) {
    if (left.scheduledToday != right.scheduledToday) {
      return left.scheduledToday ? -1 : 1;
    }
    if (left.completedToday != right.completedToday) {
      return left.completedToday ? 1 : -1;
    }
    final leftHour = left.habit.schedule.reminderHour ?? 99;
    final rightHour = right.habit.schedule.reminderHour ?? 99;
    final leftMinute = left.habit.schedule.reminderMinute ?? 99;
    final rightMinute = right.habit.schedule.reminderMinute ?? 99;

    final hourCompare = leftHour.compareTo(rightHour);
    if (hourCompare != 0) {
      return hourCompare;
    }
    final minuteCompare = leftMinute.compareTo(rightMinute);
    if (minuteCompare != 0) {
      return minuteCompare;
    }
    return left.habit.title.compareTo(right.habit.title);
  }

  Future<List<Habit>> _allActiveHabits() async {
    final rows = await _buildJoinedQuery(DateTime.now().dayKey).get();
    return rows.map(_mapHabit).toList();
  }
}
