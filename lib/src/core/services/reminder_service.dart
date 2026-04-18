import '../../features/habits/domain/habit_models.dart';

abstract class ReminderService {
  Future<void> initialize();

  Future<bool> requestPermissions();

  Future<bool> areNotificationsEnabled();

  Future<void> syncHabitReminder(Habit habit);

  Future<void> cancelHabitReminder(int habitId);

  Future<void> syncAllHabitReminders(List<Habit> habits);

  Future<String?> getLocalTimeZone();

  Future<void> dispose();
}
