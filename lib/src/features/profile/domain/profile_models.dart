import 'package:equatable/equatable.dart';

import '../../../core/services/progress_calculator.dart';

class ProfileOptions {
  static const goals = [
    'Учебная дисциплина',
    'Фокус и концентрация',
    'Энергия и здоровье',
    'Стабильный режим',
  ];

  static const routines = [
    'Жаворонок',
    'Сбалансированный день',
    'Ночная учеба',
  ];
}

class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.goal,
    required this.routine,
    required this.onboardingCompleted,
    required this.notificationsEnabled,
    required this.timeZone,
  });

  final String name;
  final String goal;
  final String routine;
  final bool onboardingCompleted;
  final bool notificationsEnabled;
  final String? timeZone;

  @override
  List<Object?> get props => [
        name,
        goal,
        routine,
        onboardingCompleted,
        notificationsEnabled,
        timeZone,
      ];
}

class UserProfileDraft extends Equatable {
  const UserProfileDraft({
    required this.name,
    required this.goal,
    required this.routine,
  });

  final String name;
  final String goal;
  final String routine;

  @override
  List<Object?> get props => [name, goal, routine];
}

class UserProgress extends Equatable {
  const UserProgress({
    required this.totalXp,
    required this.level,
    required this.currentStreak,
    required this.bestStreak,
    required this.completedToday,
    required this.totalCompletions,
  });

  const UserProgress.empty()
      : totalXp = 0,
        level = 1,
        currentStreak = 0,
        bestStreak = 0,
        completedToday = 0,
        totalCompletions = 0;

  final int totalXp;
  final int level;
  final int currentStreak;
  final int bestStreak;
  final int completedToday;
  final int totalCompletions;

  int get nextLevelTarget => ProgressCalculator.nextLevelTarget(totalXp);

  int get xpInsideCurrentLevel => ProgressCalculator.xpInsideCurrentLevel(totalXp);

  double get levelProgress => ProgressCalculator.progressToNextLevel(totalXp);

  @override
  List<Object?> get props => [
        totalXp,
        level,
        currentStreak,
        bestStreak,
        completedToday,
        totalCompletions,
      ];
}
