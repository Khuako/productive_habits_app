import '../../../core/utils/habit_style.dart';
import '../domain/habit_models.dart';
import '../domain/habit_repository.dart';

class LocalRecommendationEngine implements RecommendationEngine {
  static final List<HabitTemplate> _templates = [
    HabitTemplate(
      id: 'deep_study',
      title: 'Глубокая учеба 25 минут',
      description: 'Один фокус-спринт без отвлечений на важной учебной задаче.',
      category: 'Учеба',
      difficulty: 2,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5],
        reminderEnabled: true,
        reminderHour: 9,
        reminderMinute: 0,
      ),
      goalTags: ['Учебная дисциплина', 'Фокус и концентрация'],
      routineTags: ['Жаворонок', 'Сбалансированный день'],
    ),
    HabitTemplate(
      id: 'plan_day',
      title: 'План на день',
      description: 'Составь короткий план из трех приоритетов на сегодня.',
      category: 'Учеба',
      difficulty: 1,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5, 6, 7],
        reminderEnabled: true,
        reminderHour: 8,
        reminderMinute: 30,
      ),
      goalTags: ['Учебная дисциплина', 'Стабильный режим'],
      routineTags: ['Жаворонок', 'Сбалансированный день'],
    ),
    HabitTemplate(
      id: 'water',
      title: 'Стакан воды после пробуждения',
      description: 'Запусти день с простой привычки, которая легко закрепляется.',
      category: 'Здоровье',
      difficulty: 1,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5, 6, 7],
        reminderEnabled: true,
        reminderHour: 7,
        reminderMinute: 30,
      ),
      goalTags: ['Энергия и здоровье', 'Стабильный режим'],
      routineTags: ['Жаворонок', 'Сбалансированный день'],
    ),
    HabitTemplate(
      id: 'stretch',
      title: '5 минут разминки',
      description: 'Короткая активность между учебными блоками.',
      category: 'Здоровье',
      difficulty: 1,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5],
        reminderEnabled: true,
        reminderHour: 13,
        reminderMinute: 0,
      ),
      goalTags: ['Энергия и здоровье', 'Фокус и концентрация'],
      routineTags: ['Сбалансированный день', 'Ночная учеба'],
    ),
    HabitTemplate(
      id: 'reading',
      title: '10 минут чтения',
      description: 'Небольшой блок чтения перед сном или после учебы.',
      category: 'Саморазвитие',
      difficulty: 1,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5, 6, 7],
        reminderEnabled: true,
        reminderHour: 21,
        reminderMinute: 30,
      ),
      goalTags: ['Стабильный режим', 'Учебная дисциплина'],
      routineTags: ['Сбалансированный день', 'Ночная учеба'],
    ),
    HabitTemplate(
      id: 'focus_shutdown',
      title: '15 минут цифрового детокса',
      description: 'Убери уведомления и дай мозгу переключиться перед сном.',
      category: 'Баланс',
      difficulty: 2,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5, 6, 7],
        reminderEnabled: true,
        reminderHour: 22,
        reminderMinute: 15,
      ),
      goalTags: ['Стабильный режим', 'Фокус и концентрация'],
      routineTags: ['Ночная учеба', 'Сбалансированный день'],
    ),
    HabitTemplate(
      id: 'reflection',
      title: 'Итог дня в 3 строках',
      description: 'Короткая рефлексия: что получилось, что улучшить завтра.',
      category: 'Баланс',
      difficulty: 1,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5, 6, 7],
        reminderEnabled: true,
        reminderHour: 20,
        reminderMinute: 45,
      ),
      goalTags: ['Стабильный режим', 'Учебная дисциплина'],
      routineTags: ['Сбалансированный день', 'Ночная учеба'],
    ),
    HabitTemplate(
      id: 'morning_review',
      title: 'Повтор конспекта 10 минут',
      description: 'Быстрый разогрев мозга перед основной учебной сессией.',
      category: 'Фокус',
      difficulty: 2,
      schedule: const HabitSchedule(
        weekdays: [1, 2, 3, 4, 5],
        reminderEnabled: true,
        reminderHour: 10,
        reminderMinute: 0,
      ),
      goalTags: ['Фокус и концентрация', 'Учебная дисциплина'],
      routineTags: ['Жаворонок', 'Сбалансированный день'],
    ),
  ];

  @override
  List<HabitTemplate> recommend({
    required String goal,
    required String routine,
  }) {
    final scored = _templates.map((template) {
      final goalScore = template.goalTags.contains(goal) ? 2 : 0;
      final routineScore = template.routineTags.contains(routine) ? 1 : 0;
      final categoryBonus = HabitStyle.categories.contains(template.category) ? 1 : 0;
      return (template, goalScore + routineScore + categoryBonus);
    }).toList()
      ..sort((a, b) => b.$2.compareTo(a.$2));

    return scored.map((entry) => entry.$1).toList();
  }
}
