class StreakMetrics {
  const StreakMetrics({
    required this.currentStreak,
    required this.bestStreak,
  });

  final int currentStreak;
  final int bestStreak;
}

class ProgressCalculator {
  static const int xpPerLevel = 120;

  static StreakMetrics calculateStreaks(
    Iterable<String> uniqueDayKeys, {
    DateTime? today,
  }) {
    final now = today ?? DateTime.now();
    final dates = uniqueDayKeys
        .map((value) => DateTime.parse(value))
        .map((value) => DateTime(value.year, value.month, value.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    if (dates.isEmpty) {
      return const StreakMetrics(currentStreak: 0, bestStreak: 0);
    }

    var bestStreak = 1;
    var rollingBest = 1;
    for (var index = 1; index < dates.length; index++) {
      final difference = dates[index - 1].difference(dates[index]).inDays;
      if (difference == 1) {
        rollingBest += 1;
        if (rollingBest > bestStreak) {
          bestStreak = rollingBest;
        }
      } else {
        rollingBest = 1;
      }
    }

    final todayOnly = DateTime(now.year, now.month, now.day);
    final yesterday = todayOnly.subtract(const Duration(days: 1));
    final latest = dates.first;

    if (latest.isBefore(yesterday)) {
      return StreakMetrics(currentStreak: 0, bestStreak: bestStreak);
    }

    var currentStreak = 1;
    for (var index = 1; index < dates.length; index++) {
      final difference = dates[index - 1].difference(dates[index]).inDays;
      if (difference == 1) {
        currentStreak += 1;
      } else {
        break;
      }
    }

    return StreakMetrics(
      currentStreak: currentStreak,
      bestStreak: bestStreak,
    );
  }

  static int levelForXp(int totalXp) {
    return (totalXp ~/ xpPerLevel) + 1;
  }

  static int xpFloorForLevel(int level) {
    return (level - 1) * xpPerLevel;
  }

  static int nextLevelTarget(int totalXp) {
    return levelForXp(totalXp) * xpPerLevel;
  }

  static int xpInsideCurrentLevel(int totalXp) {
    return totalXp - xpFloorForLevel(levelForXp(totalXp));
  }

  static double progressToNextLevel(int totalXp) {
    final level = levelForXp(totalXp);
    final floor = xpFloorForLevel(level);
    final ceiling = xpFloorForLevel(level + 1);
    if (ceiling == floor) {
      return 0;
    }
    return (totalXp - floor) / (ceiling - floor);
  }
}
