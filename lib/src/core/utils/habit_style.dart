import 'package:flutter/material.dart';

class HabitVisualData {
  const HabitVisualData({
    required this.iconKey,
    required this.icon,
    required this.color,
  });

  final String iconKey;
  final IconData icon;
  final Color color;
}

class HabitStyle {
  static const categories = [
    'Учеба',
    'Фокус',
    'Здоровье',
    'Баланс',
    'Саморазвитие',
  ];

  static HabitVisualData byCategory(String category) {
    switch (category) {
      case 'Учеба':
        return const HabitVisualData(
          iconKey: 'school',
          icon: Icons.school_rounded,
          color: Color(0xFF3B82F6),
        );
      case 'Фокус':
        return const HabitVisualData(
          iconKey: 'timer',
          icon: Icons.timer_rounded,
          color: Color(0xFFF97316),
        );
      case 'Здоровье':
        return const HabitVisualData(
          iconKey: 'favorite',
          icon: Icons.favorite_rounded,
          color: Color(0xFFEF4444),
        );
      case 'Баланс':
        return const HabitVisualData(
          iconKey: 'self_improvement',
          icon: Icons.self_improvement_rounded,
          color: Color(0xFF8B5CF6),
        );
      case 'Саморазвитие':
      default:
        return const HabitVisualData(
          iconKey: 'auto_stories',
          icon: Icons.auto_stories_rounded,
          color: Color(0xFF0F766E),
        );
    }
  }

  static IconData iconFromKey(String iconKey) {
    switch (iconKey) {
      case 'school':
        return Icons.school_rounded;
      case 'timer':
        return Icons.timer_rounded;
      case 'favorite':
        return Icons.favorite_rounded;
      case 'self_improvement':
        return Icons.self_improvement_rounded;
      case 'auto_stories':
      default:
        return Icons.auto_stories_rounded;
    }
  }

  static String difficultyLabel(int difficulty) {
    switch (difficulty) {
      case 1:
        return 'Легкая';
      case 2:
        return 'Средняя';
      case 3:
      default:
        return 'Сильный вызов';
    }
  }

  static int xpForDifficulty(int difficulty) {
    switch (difficulty) {
      case 1:
        return 20;
      case 2:
        return 35;
      case 3:
      default:
        return 50;
    }
  }
}
