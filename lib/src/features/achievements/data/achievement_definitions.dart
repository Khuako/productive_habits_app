import '../domain/achievement_models.dart';

class AchievementDefinitions {
  static const all = [
    AchievementDefinition(
      key: 'first_step',
      title: 'Первый шаг',
      description: 'Отметь первую выполненную привычку.',
      iconName: 'rocket_launch',
      threshold: 1,
    ),
    AchievementDefinition(
      key: 'streak_3',
      title: '3 дня подряд',
      description: 'Собери серию из трех продуктивных дней.',
      iconName: 'local_fire_department',
      threshold: 3,
    ),
    AchievementDefinition(
      key: 'streak_7',
      title: 'Неделя ритма',
      description: 'Удерживай серию в течение семи дней.',
      iconName: 'emoji_events',
      threshold: 7,
    ),
    AchievementDefinition(
      key: 'xp_200',
      title: '200 XP',
      description: 'Накопи двести очков прогресса.',
      iconName: 'stars',
      threshold: 200,
    ),
    AchievementDefinition(
      key: 'habit_builder',
      title: 'Конструктор системы',
      description: 'Создай пять активных привычек.',
      iconName: 'checklist',
      threshold: 5,
    ),
  ];

  static Map<String, AchievementDefinition> get byKey {
    return {for (final definition in all) definition.key: definition};
  }
}
