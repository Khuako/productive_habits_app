import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:productive_habits_app/src/core/utils/date_utils.dart';
import 'package:productive_habits_app/src/data/local/app_database.dart';
import 'package:productive_habits_app/src/features/recovery/data/drift_recovery_repository.dart';
import 'package:productive_habits_app/src/features/recovery/domain/recovery_models.dart';
import 'package:productive_habits_app/src/features/recovery/domain/recovery_rule_engine.dart';

void main() {
  group('DriftRecoveryRepository', () {
    late AppDatabase database;
    late DriftRecoveryRepository repository;

    setUp(() {
      database = AppDatabase.forTesting(NativeDatabase.memory());
      repository = DriftRecoveryRepository(
        database: database,
        ruleEngine: const RecoveryRuleEngine(),
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('acceptLightPlan marks today recovery day as accepted', () async {
      await _seedHabit(
        database,
        title: 'Сон',
        priority: 3,
        difficulty: 2,
      );
      await _seedHabit(
        database,
        title: 'Вода',
        priority: 2,
        difficulty: 1,
      );
      await _seedHabit(
        database,
        title: 'Прогулка',
        priority: 1,
        difficulty: 3,
      );

      await repository.submitDailyCheckIn(
        const DailyCheckInDraft(
          energy: RecoveryLevel.low,
          load: RecoveryLevel.high,
          mood: RecoveryLevel.low,
        ),
      );

      await repository.acceptLightPlan(DateTime.now().dayKey);
      final state = await repository.getTodayState();

      expect(state, isNotNull);
      expect(state!.status, RecoveryDayStatus.recovery);
      expect(state.lightPlanAccepted, isTrue);
      expect(state.lightPlanAcceptedAt, isNotNull);
      expect(state.suggestedHabitIds, hasLength(3));
    });

    test('watchWeeklyReview aggregates status counts and completion rates', () async {
      final today = DateTime.now().dateOnly;
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final habitA = await _seedHabit(database, title: 'A', priority: 3, difficulty: 2);
      final habitB = await _seedHabit(database, title: 'B', priority: 2, difficulty: 2);

      await _insertRecoveryDay(
        database,
        day: today,
        status: RecoveryDayStatus.recovery,
        reasons: const ['Мало энергии'],
        suggestedHabitIds: [habitA, habitB],
      );
      await _insertRecoveryDay(
        database,
        day: yesterday,
        status: RecoveryDayStatus.tense,
        reasons: const ['Высокая нагрузка'],
      );
      await _insertRecoveryDay(
        database,
        day: twoDaysAgo,
        status: RecoveryDayStatus.normal,
      );

      await _insertCompletion(database, habitId: habitA, day: today);
      await _insertCompletion(database, habitId: habitA, day: yesterday);
      await _insertCompletion(database, habitId: habitB, day: twoDaysAgo);

      final review = await repository.watchWeeklyReview(days: 7).first;

      expect(review.normalDays, 1);
      expect(review.tenseDays, 1);
      expect(review.recoveryDays, 1);
      expect(review.recoveryCompletionRate, closeTo(0.5, 0.001));
      expect(review.regularCompletionRate, closeTo(0.5, 0.001));
    });

    test('watchDifficultPeriodInsight explains common reasons and low completion', () async {
      final today = DateTime.now().dateOnly;
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final habitA = await _seedHabit(database, title: 'A', priority: 3, difficulty: 2);
      final habitB = await _seedHabit(database, title: 'B', priority: 2, difficulty: 2);

      await _insertRecoveryDay(
        database,
        day: today,
        status: RecoveryDayStatus.recovery,
        reasons: const ['Мало энергии', 'Высокая нагрузка'],
        suggestedHabitIds: [habitA, habitB],
      );
      await _insertRecoveryDay(
        database,
        day: yesterday,
        status: RecoveryDayStatus.tense,
        reasons: const ['Мало энергии'],
      );
      await _insertRecoveryDay(
        database,
        day: twoDaysAgo,
        status: RecoveryDayStatus.recovery,
        reasons: const ['Мало энергии'],
        suggestedHabitIds: [habitA, habitB],
      );

      await _insertCompletion(database, habitId: habitA, day: yesterday);

      final insight = await repository.watchDifficultPeriodInsight(days: 14).first;

      expect(insight.hasData, isTrue);
      expect(insight.explanations, isNotEmpty);
      expect(insight.explanations.first, contains('Мало энергии'));
      expect(
        insight.explanations.join(' '),
        contains('выполнение'),
      );
    });

    test('returns stable empty models when recovery data is missing', () async {
      final review = await repository.watchWeeklyReview(days: 7).first;
      final history = await repository.watchRecoveryHistory(days: 30).first;
      final insight = await repository.watchDifficultPeriodInsight(days: 14).first;

      expect(review, WeeklyRecoveryReview.empty());
      expect(history, isEmpty);
      expect(insight.hasData, isFalse);
      expect(insight.explanations, isEmpty);
      expect(
        insight.summary,
        contains('недостаточно recovery-данных'),
      );
    });
  });
}

Future<int> _seedHabit(
  AppDatabase database, {
  required String title,
  required int priority,
  required int difficulty,
}) async {
  final id = await database.into(database.habits).insert(
        HabitsCompanion.insert(
          title: title,
          description: const drift.Value('desc'),
          category: 'health',
          difficulty: difficulty,
          priority: drift.Value(priority),
          iconName: 'water',
          colorValue: 0xFF0F766E,
          xpReward: 10,
        ),
      );
  await database.into(database.habitSchedules).insert(
        HabitSchedulesCompanion.insert(
          habitId: id,
          weekdays: encodeWeekdays(const [1, 2, 3, 4, 5, 6, 7]),
        ),
      );
  return id;
}

Future<void> _insertCompletion(
  AppDatabase database, {
  required int habitId,
  required DateTime day,
}) {
  return database.into(database.habitCompletions).insert(
        HabitCompletionsCompanion.insert(
          habitId: habitId,
          dayKey: day.dayKey,
          completedAt: day.add(const Duration(hours: 9)),
          awardedXp: 10,
        ),
      );
}

Future<void> _insertRecoveryDay(
  AppDatabase database, {
  required DateTime day,
  required RecoveryDayStatus status,
  List<String> reasons = const [],
  List<int> suggestedHabitIds = const [],
}) {
  return database.into(database.recoveryDayEntries).insert(
        RecoveryDayEntriesCompanion.insert(
          dayKey: day.dayKey,
          status: status.name,
          riskScore: drift.Value(status == RecoveryDayStatus.recovery ? 8 : 4),
          reasons: drift.Value(reasons.join('||')),
          suggestedHabitIds: drift.Value(
            suggestedHabitIds.map((id) => id.toString()).join(','),
          ),
          lightPlanAccepted: const drift.Value(false),
          createdAt: day.add(const Duration(hours: 8)),
        ),
      );
}
