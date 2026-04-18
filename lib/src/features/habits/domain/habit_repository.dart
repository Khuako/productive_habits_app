import 'habit_models.dart';

abstract class HabitRepository {
  Stream<List<HabitItem>> watchAllHabits({DateTime? forDay});

  Stream<List<HabitItem>> watchTodayHabits({DateTime? day});

  Future<Habit?> getHabitById(int id);

  Future<int> createHabit(HabitDraft draft);

  Future<void> updateHabit(int id, HabitDraft draft);

  Future<void> archiveHabit(int id);

  Future<void> toggleCompletion(int habitId, {DateTime? onDay});

  Future<void> addTemplates(List<HabitTemplate> templates);

  Future<void> syncAllReminders();
}

abstract class RecommendationEngine {
  List<HabitTemplate> recommend({
    required String goal,
    required String routine,
  });
}
