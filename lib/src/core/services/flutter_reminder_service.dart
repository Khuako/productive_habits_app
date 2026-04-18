import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../core/utils/date_utils.dart';
import '../../features/habits/domain/habit_models.dart';
import 'reminder_service.dart';

class FlutterReminderService implements ReminderService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  String? _timeZoneIdentifier;

  @override
  Future<void> initialize() async {
    tz.initializeTimeZones();
    await _configureLocalTimeZone();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
      macOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _plugin.initialize(settings: initializationSettings);
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux || Platform.isWindows) {
      _timeZoneIdentifier = 'UTC';
      return;
    }

    try {
      final info = await FlutterTimezone.getLocalTimezone();
      _timeZoneIdentifier = info.identifier;
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      _timeZoneIdentifier = 'UTC';
      tz.setLocalLocation(tz.UTC);
    }
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.areNotificationsEnabled() ?? false;
    }
    return true;
  }

  @override
  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.requestNotificationsPermission() ?? false;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }

    return true;
  }

  @override
  Future<void> syncAllHabitReminders(List<Habit> habits) async {
    for (final habit in habits) {
      await syncHabitReminder(habit);
    }
  }

  @override
  Future<void> syncHabitReminder(Habit habit) async {
    await cancelHabitReminder(habit.id);

    if (!habit.schedule.reminderEnabled ||
        habit.schedule.reminderHour == null ||
        habit.schedule.reminderMinute == null) {
      return;
    }

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_reminders',
        'Напоминания о привычках',
        channelDescription: 'Локальные уведомления по расписанию привычек',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
    );

    for (final weekday in habit.schedule.weekdays) {
      final nextDate = nextOccurrenceForWeekday(
        from: DateTime.now(),
        weekday: weekday,
        hour: habit.schedule.reminderHour!,
        minute: habit.schedule.reminderMinute!,
      );

      await _plugin.zonedSchedule(
        id: _notificationId(habit.id, weekday),
        title: 'Пора заняться привычкой',
        body: habit.title,
        scheduledDate: tz.TZDateTime.from(nextDate, tz.local),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: 'habit:${habit.id}',
      );
    }
  }

  @override
  Future<void> cancelHabitReminder(int habitId) async {
    for (var weekday = 1; weekday <= 7; weekday++) {
      await _plugin.cancel(id: _notificationId(habitId, weekday));
    }
  }

  int _notificationId(int habitId, int weekday) => (habitId * 10) + weekday;

  @override
  Future<String?> getLocalTimeZone() async => _timeZoneIdentifier;

  @override
  Future<void> dispose() async {}
}
