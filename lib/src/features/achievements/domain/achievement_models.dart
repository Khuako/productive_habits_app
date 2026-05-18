import 'package:equatable/equatable.dart';

class AchievementDefinition extends Equatable {
  const AchievementDefinition({
    required this.key,
    required this.title,
    required this.description,
    required this.iconName,
    required this.threshold,
  });

  final String key;
  final String title;
  final String description;
  final String iconName;
  final int threshold;

  @override
  List<Object?> get props => [key, title, description, iconName, threshold];
}

class Achievement extends Equatable {
  const Achievement({
    required this.key,
    required this.title,
    required this.description,
    required this.iconName,
    required this.threshold,
    required this.progress,
    required this.unlockedAt,
  });

  final String key;
  final String title;
  final String description;
  final String iconName;
  final int threshold;
  final int progress;
  final DateTime? unlockedAt;

  bool get isUnlocked => unlockedAt != null;

  int get displayProgress {
    if (threshold <= 0) {
      return 0;
    }
    return progress.clamp(0, threshold);
  }

  double get progressFraction {
    if (threshold == 0) {
      return 0;
    }
    return (displayProgress / threshold).toDouble();
  }

  @override
  List<Object?> get props => [
        key,
        title,
        description,
        iconName,
        threshold,
        progress,
        unlockedAt,
      ];
}
