import 'package:equatable/equatable.dart';

enum RecoveryLevel {
  low,
  medium,
  high;

  String get label => switch (this) {
        RecoveryLevel.low => 'Низко',
        RecoveryLevel.medium => 'Средне',
        RecoveryLevel.high => 'Высоко',
      };

  int get dbValue => index + 1;

  static RecoveryLevel fromDbValue(int value) {
    return RecoveryLevel.values[value.clamp(1, 3) - 1];
  }
}

enum RecoveryDayStatus {
  normal,
  tense,
  recovery;

  String get title => switch (this) {
        RecoveryDayStatus.normal => 'Нормальный день',
        RecoveryDayStatus.tense => 'Напряженный день',
        RecoveryDayStatus.recovery => 'День восстановления',
      };

  String get summary => switch (this) {
        RecoveryDayStatus.normal =>
          'Ритм выглядит устойчиво, можно держать обычный план.',
        RecoveryDayStatus.tense =>
          'Нагрузка подросла. Стоит упростить фокус, если день пойдет тяжело.',
        RecoveryDayStatus.recovery =>
          'Сегодня лучше снизить нагрузку и удержать только базовый ритм.',
      };
}

class DailyCheckInDraft extends Equatable {
  const DailyCheckInDraft({
    required this.energy,
    required this.load,
    required this.mood,
  });

  final RecoveryLevel energy;
  final RecoveryLevel load;
  final RecoveryLevel mood;

  @override
  List<Object?> get props => [energy, load, mood];
}

class RecoveryEvaluationInput extends Equatable {
  const RecoveryEvaluationInput({
    required this.energy,
    required this.load,
    required this.mood,
    required this.plannedHabitsCount,
    required this.currentStreak,
    required this.recentMissedDays,
  });

  final RecoveryLevel energy;
  final RecoveryLevel load;
  final RecoveryLevel mood;
  final int plannedHabitsCount;
  final int currentStreak;
  final int recentMissedDays;

  @override
  List<Object?> get props => [
        energy,
        load,
        mood,
        plannedHabitsCount,
        currentStreak,
        recentMissedDays,
      ];
}

class RecoveryEvaluationResult extends Equatable {
  const RecoveryEvaluationResult({
    required this.status,
    required this.riskScore,
    required this.reasons,
  });

  final RecoveryDayStatus status;
  final int riskScore;
  final List<String> reasons;

  @override
  List<Object?> get props => [status, riskScore, reasons];
}

class RecoveryDayState extends Equatable {
  const RecoveryDayState({
    required this.dayKey,
    required this.status,
    required this.riskScore,
    required this.reasons,
    required this.suggestedHabitIds,
    required this.createdAt,
  });

  final String dayKey;
  final RecoveryDayStatus status;
  final int riskScore;
  final List<String> reasons;
  final List<int> suggestedHabitIds;
  final DateTime createdAt;

  bool get shouldSuggestLightMode => status == RecoveryDayStatus.recovery;

  @override
  List<Object?> get props => [
        dayKey,
        status,
        riskScore,
        reasons,
        suggestedHabitIds,
        createdAt,
      ];
}
