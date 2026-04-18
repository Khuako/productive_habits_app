import 'package:equatable/equatable.dart';

import '../../../core/utils/date_utils.dart';
import '../../../core/utils/habit_style.dart';

class HabitSchedule extends Equatable {
  const HabitSchedule({
    required this.weekdays,
    required this.reminderEnabled,
    required this.reminderHour,
    required this.reminderMinute,
  });

  final List<int> weekdays;
  final bool reminderEnabled;
  final int? reminderHour;
  final int? reminderMinute;

  bool isScheduledFor(DateTime date) => weekdays.contains(date.weekday);

  String get weekdayLabel => weekdaysToLabel(weekdays);

  String get reminderLabel => formatReminderTime(reminderHour, reminderMinute);

  HabitSchedule copyWith({
    List<int>? weekdays,
    bool? reminderEnabled,
    int? reminderHour,
    int? reminderMinute,
  }) {
    return HabitSchedule(
      weekdays: weekdays ?? this.weekdays,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
    );
  }

  @override
  List<Object?> get props => [weekdays, reminderEnabled, reminderHour, reminderMinute];
}

class Habit extends Equatable {
  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.priority,
    required this.iconName,
    required this.colorValue,
    required this.xpReward,
    required this.createdAt,
    required this.isArchived,
    required this.schedule,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final int difficulty;
  final int priority;
  final String iconName;
  final int colorValue;
  final int xpReward;
  final DateTime createdAt;
  final bool isArchived;
  final HabitSchedule schedule;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        difficulty,
        priority,
        iconName,
        colorValue,
        xpReward,
        createdAt,
        isArchived,
        schedule,
      ];
}

class HabitCompletion extends Equatable {
  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.dayKey,
    required this.completedAt,
    required this.awardedXp,
    required this.streakAfterCompletion,
  });

  final int id;
  final int habitId;
  final String dayKey;
  final DateTime completedAt;
  final int awardedXp;
  final int streakAfterCompletion;

  @override
  List<Object?> get props => [
        id,
        habitId,
        dayKey,
        completedAt,
        awardedXp,
        streakAfterCompletion,
      ];
}

class HabitDraft extends Equatable {
  const HabitDraft({
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.priority,
    required this.schedule,
    this.iconName,
    this.colorValue,
    this.xpReward,
  });

  final String title;
  final String description;
  final String category;
  final int difficulty;
  final int priority;
  final HabitSchedule schedule;
  final String? iconName;
  final int? colorValue;
  final int? xpReward;

  HabitDraft withVisualDefaults() {
    final visual = HabitStyle.byCategory(category);
    return HabitDraft(
      title: title,
      description: description,
      category: category,
      difficulty: difficulty,
      priority: priority,
      schedule: schedule,
      iconName: iconName ?? visual.iconKey,
      colorValue: colorValue ?? visual.color.toARGB32(),
      xpReward: xpReward ?? HabitStyle.xpForDifficulty(difficulty),
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        difficulty,
        priority,
        schedule,
        iconName,
        colorValue,
        xpReward,
      ];
}

class HabitTemplate extends Equatable {
  const HabitTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.schedule,
    required this.goalTags,
    required this.routineTags,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final int difficulty;
  final HabitSchedule schedule;
  final List<String> goalTags;
  final List<String> routineTags;

  HabitDraft toDraft() {
    return HabitDraft(
      title: title,
      description: description,
      category: category,
      difficulty: difficulty,
      priority: 2,
      schedule: schedule,
    ).withVisualDefaults();
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        difficulty,
        schedule,
        goalTags,
        routineTags,
      ];
}

class HabitItem extends Equatable {
  const HabitItem({
    required this.habit,
    required this.completedToday,
    required this.scheduledToday,
    required this.completedAt,
  });

  final Habit habit;
  final bool completedToday;
  final bool scheduledToday;
  final DateTime? completedAt;

  String get subtitle {
    final pieces = <String>[
      priorityLabel(habit.priority),
      habit.schedule.weekdayLabel,
      habit.schedule.reminderLabel,
      '${habit.xpReward} XP',
    ];
    return pieces.join(' • ');
  }

  @override
  List<Object?> get props => [habit, completedToday, scheduledToday, completedAt];
}

String priorityLabel(int priority) {
  switch (priority) {
    case 3:
      return 'Ключевая';
    case 2:
      return 'Важная';
    case 1:
    default:
      return 'Гибкая';
  }
}
