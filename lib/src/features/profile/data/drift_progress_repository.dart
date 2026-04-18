import 'package:drift/drift.dart';

import '../../../core/services/progress_calculator.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/local/app_database.dart' hide UserProfile;
import '../../../data/local/app_database.dart' as local_db show UserProfile;
import '../../achievements/data/achievement_definitions.dart';
import '../../achievements/domain/achievement_repository.dart';
import '../../statistics/domain/daily_progress.dart';
import '../domain/profile_models.dart';
import '../domain/progress_repository.dart';

class DriftProgressRepository implements ProgressRepository {
  DriftProgressRepository({
    required AppDatabase database,
    required AchievementRepository achievementRepository,
  })  : _database = database,
        _achievementRepository = achievementRepository;

  final AppDatabase _database;
  final AchievementRepository _achievementRepository;

  @override
  Future<void> ensureDefaults() async {
    final progressEntry = await (_database.select(_database.userProgressEntries)
          ..where((tbl) => tbl.id.equals(1)))
        .getSingleOrNull();
    if (progressEntry == null) {
      await _database.into(_database.userProgressEntries).insert(
            const UserProgressEntriesCompanion(
              id: Value(1),
              totalXp: Value(0),
              level: Value(1),
              currentStreak: Value(0),
              bestStreak: Value(0),
              completedToday: Value(0),
              totalCompletions: Value(0),
            ),
          );
    }
  }

  @override
  Future<UserProfile?> getUserProfile() async {
    final entry = await (_database.select(_database.userProfiles)
          ..where((tbl) => tbl.id.equals(1)))
        .getSingleOrNull();
    return entry == null ? null : _mapProfile(entry);
  }

  @override
  Stream<UserProfile?> watchUserProfile() {
    return (_database.select(_database.userProfiles)
          ..where((tbl) => tbl.id.equals(1)))
        .watchSingleOrNull()
        .map((entry) => entry == null ? null : _mapProfile(entry));
  }

  @override
  Future<void> saveProfile(UserProfileDraft draft) async {
    final existing = await getUserProfile();
    await _database.into(_database.userProfiles).insertOnConflictUpdate(
          UserProfilesCompanion(
            id: const Value(1),
            name: Value(draft.name),
            goal: Value(draft.goal),
            routine: Value(draft.routine),
            onboardingCompleted: const Value(true),
            notificationsEnabled: Value(existing?.notificationsEnabled ?? false),
            timeZone: Value(existing?.timeZone),
            createdAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Stream<UserProgress> watchProgress() {
    return (_database.select(_database.userProgressEntries)
          ..where((tbl) => tbl.id.equals(1)))
        .watchSingleOrNull()
        .map((entry) {
      if (entry == null) {
        return const UserProgress.empty();
      }
      return UserProgress(
        totalXp: entry.totalXp,
        level: entry.level,
        currentStreak: entry.currentStreak,
        bestStreak: entry.bestStreak,
        completedToday: entry.completedToday,
        totalCompletions: entry.totalCompletions,
      );
    });
  }

  @override
  Stream<List<DailyProgress>> watchWeeklySummary({int days = 7}) {
    return (_database.select(_database.userProgressEntries)
          ..where((tbl) => tbl.id.equals(1)))
        .watchSingleOrNull()
        .asyncMap((_) => _buildWeeklySummary(days));
  }

  @override
  Future<void> refreshDerivedState() async {
    await _achievementRepository.ensureSeeded();

    final completions = await _database.select(_database.habitCompletions).get();
    final activeHabits = await (_database.select(_database.habits)
          ..where((tbl) => tbl.isArchived.equals(false)))
        .get();

    final totalXp = completions.fold<int>(0, (sum, completion) => sum + completion.awardedXp);
    final totalCompletions = completions.length;
    final streakMetrics = ProgressCalculator.calculateStreaks(
      completions.map((completion) => completion.dayKey).toSet(),
    );
    final todayKey = DateTime.now().dayKey;
    final completedToday =
        completions.where((completion) => completion.dayKey == todayKey).length;

    await _database.into(_database.userProgressEntries).insertOnConflictUpdate(
          UserProgressEntriesCompanion(
            id: const Value(1),
            totalXp: Value(totalXp),
            level: Value(ProgressCalculator.levelForXp(totalXp)),
            currentStreak: Value(streakMetrics.currentStreak),
            bestStreak: Value(streakMetrics.bestStreak),
            completedToday: Value(completedToday),
            totalCompletions: Value(totalCompletions),
          ),
        );

    await _updateAchievementProgress(
      totalXp: totalXp,
      totalCompletions: totalCompletions,
      activeHabitCount: activeHabits.length,
      bestStreak: streakMetrics.bestStreak,
    );
  }

  Future<void> _updateAchievementProgress({
    required int totalXp,
    required int totalCompletions,
    required int activeHabitCount,
    required int bestStreak,
  }) async {
    final existing = await _database.select(_database.achievementEntries).get();
    final existingMap = {for (final entry in existing) entry.key: entry};
    final now = DateTime.now();

    for (final definition in AchievementDefinitions.all) {
      final currentValue = switch (definition.key) {
        'first_step' => totalCompletions,
        'streak_3' => bestStreak,
        'streak_7' => bestStreak,
        'xp_200' => totalXp,
        'habit_builder' => activeHabitCount,
        _ => 0,
      };

      final existingEntry = existingMap[definition.key];
      final unlockedAt = existingEntry?.unlockedAt ??
          (currentValue >= definition.threshold ? now : null);

      await _database.into(_database.achievementEntries).insertOnConflictUpdate(
            AchievementEntriesCompanion(
              key: Value(definition.key),
              progress: Value(currentValue),
              unlockedAt: Value(unlockedAt),
            ),
          );
    }
  }

  @override
  Future<void> updateNotifications({
    required bool enabled,
    String? timeZone,
  }) async {
    final existing = await (_database.select(_database.userProfiles)
          ..where((tbl) => tbl.id.equals(1)))
        .getSingleOrNull();

    await _database.into(_database.userProfiles).insertOnConflictUpdate(
          UserProfilesCompanion(
            id: const Value(1),
            name: Value(existing?.name),
            goal: Value(existing?.goal),
            routine: Value(existing?.routine),
            onboardingCompleted: Value(existing?.onboardingCompleted ?? false),
            notificationsEnabled: Value(enabled),
            timeZone: Value(timeZone ?? existing?.timeZone),
            createdAt: Value(existing?.createdAt ?? DateTime.now()),
          ),
        );
  }

  Future<List<DailyProgress>> _buildWeeklySummary(int days) async {
    final endDate = DateTime.now().dateOnly;
    final startDate = endDate.subtract(Duration(days: days - 1));

    final activeHabits = await (_database.select(_database.habits)
          ..where((tbl) => tbl.isArchived.equals(false)))
        .get();
    final schedules = await _database.select(_database.habitSchedules).get();
    final scheduleByHabitId = {
      for (final schedule in schedules) schedule.habitId: parseWeekdays(schedule.weekdays),
    };

    final completions = await (_database.select(_database.habitCompletions)
          ..where((tbl) => tbl.completedAt.isBiggerOrEqualValue(startDate)))
        .get();
    final completionCountByDay = <String, int>{};
    for (final completion in completions) {
      completionCountByDay.update(
        completion.dayKey,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    final result = <DailyProgress>[];
    for (var offset = 0; offset < days; offset++) {
      final date = startDate.add(Duration(days: offset));
      final plannedCount = activeHabits.where((habit) {
        final weekdays = scheduleByHabitId[habit.id] ?? const <int>[];
        return weekdays.contains(date.weekday);
      }).length;

      result.add(
        DailyProgress(
          date: date,
          plannedCount: plannedCount,
          completedCount: completionCountByDay[date.dayKey] ?? 0,
        ),
      );
    }
    return result;
  }

  UserProfile _mapProfile(local_db.UserProfile entry) {
    return UserProfile(
      name: entry.name ?? '',
      goal: entry.goal ?? '',
      routine: entry.routine ?? '',
      onboardingCompleted: entry.onboardingCompleted,
      notificationsEnabled: entry.notificationsEnabled,
      timeZone: entry.timeZone,
    );
  }
}
