import 'recovery_models.dart';

typedef _ReasonScore = ({int weight, String message});

class RecoveryRuleEngine {
  const RecoveryRuleEngine();

  RecoveryEvaluationResult evaluate(RecoveryEvaluationInput input) {
    var score = 0;
    final reasons = <_ReasonScore>[];

    switch (input.energy) {
      case RecoveryLevel.low:
        score += 3;
        reasons.add(
          (weight: 3, message: 'Энергии сегодня мало, лучше снизить нагрузку.'),
        );
      case RecoveryLevel.medium:
        score += 1;
        reasons.add(
          (weight: 1, message: 'Энергия не на пике, стоит беречь темп.'),
        );
      case RecoveryLevel.high:
        break;
    }

    switch (input.load) {
      case RecoveryLevel.high:
        score += 2;
        reasons.add(
          (weight: 2, message: 'Сегодня нагрузка выше обычного.'),
        );
      case RecoveryLevel.medium:
        score += 1;
        reasons.add(
          (weight: 1, message: 'День выглядит плотнее обычного.'),
        );
      case RecoveryLevel.low:
        break;
    }

    switch (input.mood) {
      case RecoveryLevel.low:
        score += 2;
        reasons.add(
          (weight: 2, message: 'Настроение просело, лучше сохранить базовый ритм.'),
        );
      case RecoveryLevel.medium:
        score += 1;
        reasons.add(
          (weight: 1, message: 'Настроение нестабильное, не перегружай день.'),
        );
      case RecoveryLevel.high:
        break;
    }

    if (input.plannedHabitsCount >= 4) {
      score += 1;
      reasons.add(
        (
          weight: 1,
          message: 'На сегодня уже запланировано много привычек.',
        ),
      );
    }

    if (input.currentStreak == 0) {
      score += 1;
      reasons.add(
        (weight: 1, message: 'Ритм уже сбился, лучше начать с малого.'),
      );
    }

    if (input.recentMissedDays >= 2) {
      score += 2;
      reasons.add(
        (weight: 2, message: 'Недавние пропуски показывают риск срыва.'),
      );
    } else if (input.recentMissedDays == 1) {
      score += 1;
      reasons.add(
        (weight: 1, message: 'В последние дни уже были пропуски.'),
      );
    }

    final status = switch (score) {
      >= 7 => RecoveryDayStatus.recovery,
      >= 3 => RecoveryDayStatus.tense,
      _ => RecoveryDayStatus.normal,
    };

    final selectedReasons = status == RecoveryDayStatus.normal
        ? const <String>[]
        : (reasons.toList()
              ..sort((left, right) => right.weight.compareTo(left.weight)))
            .map((entry) => entry.message)
            .toSet()
            .take(2)
            .toList();

    return RecoveryEvaluationResult(
      status: status,
      riskScore: score,
      reasons: selectedReasons,
    );
  }
}
