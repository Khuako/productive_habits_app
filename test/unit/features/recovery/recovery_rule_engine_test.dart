import 'package:flutter_test/flutter_test.dart';
import 'package:productive_habits_app/src/features/recovery/domain/recovery_models.dart';
import 'package:productive_habits_app/src/features/recovery/domain/recovery_rule_engine.dart';

void main() {
  group('RecoveryRuleEngine', () {
    const engine = RecoveryRuleEngine();

    test('returns normal status for a stable day', () {
      final result = engine.evaluate(
        const RecoveryEvaluationInput(
          energy: RecoveryLevel.high,
          load: RecoveryLevel.low,
          mood: RecoveryLevel.high,
          plannedHabitsCount: 2,
          currentStreak: 4,
          recentMissedDays: 0,
        ),
      );

      expect(result.status, RecoveryDayStatus.normal);
      expect(result.reasons, isEmpty);
    });

    test('returns tense status for a moderately difficult day', () {
      final result = engine.evaluate(
        const RecoveryEvaluationInput(
          energy: RecoveryLevel.medium,
          load: RecoveryLevel.high,
          mood: RecoveryLevel.medium,
          plannedHabitsCount: 4,
          currentStreak: 1,
          recentMissedDays: 1,
        ),
      );

      expect(result.status, RecoveryDayStatus.tense);
      expect(result.reasons, isNotEmpty);
      expect(
        result.reasons,
        contains('Сегодня нагрузка выше обычного.'),
      );
    });

    test('returns recovery status for a high-risk day', () {
      final result = engine.evaluate(
        const RecoveryEvaluationInput(
          energy: RecoveryLevel.low,
          load: RecoveryLevel.high,
          mood: RecoveryLevel.low,
          plannedHabitsCount: 5,
          currentStreak: 0,
          recentMissedDays: 2,
        ),
      );

      expect(result.status, RecoveryDayStatus.recovery);
      expect(result.reasons.length, lessThanOrEqualTo(2));
      expect(
        result.reasons,
        contains('Энергии сегодня мало, лучше снизить нагрузку.'),
      );
    });
  });
}
