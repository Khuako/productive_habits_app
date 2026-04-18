import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DayKeyDateTime on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);

  String get dayKey => DateFormat('yyyy-MM-dd').format(this);

  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

List<int> parseWeekdays(String rawWeekdays) {
  if (rawWeekdays.trim().isEmpty) {
    return const [1, 2, 3, 4, 5];
  }

  return rawWeekdays
      .split(',')
      .where((value) => value.trim().isNotEmpty)
      .map((value) => int.parse(value.trim()))
      .toList()
    ..sort();
}

String encodeWeekdays(Iterable<int> weekdays) {
  final normalized = weekdays.toSet().toList()..sort();
  return normalized.join(',');
}

String shortWeekdayLabel(int weekday) {
  const labels = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  return labels[weekday - 1];
}

String weekdaysToLabel(List<int> weekdays) {
  final normalized = [...weekdays]..sort();
  if (normalized.length == 7) {
    return 'Каждый день';
  }
  if (normalized.length == 5 &&
      normalized.every((weekday) => weekday >= 1 && weekday <= 5)) {
    return 'Будни';
  }
  return normalized.map(shortWeekdayLabel).join(', ');
}

DateTime nextOccurrenceForWeekday({
  required DateTime from,
  required int weekday,
  required int hour,
  required int minute,
}) {
  final todayCandidate = DateTime(
    from.year,
    from.month,
    from.day,
    hour,
    minute,
  );
  var delta = weekday - from.weekday;
  if (delta < 0) {
    delta += 7;
  }
  var candidate = todayCandidate.add(Duration(days: delta));
  if (!candidate.isAfter(from)) {
    candidate = candidate.add(const Duration(days: 7));
  }
  return candidate;
}

String formatReminderTime(int? hour, int? minute) {
  if (hour == null || minute == null) {
    return 'Без времени';
  }
  return DateFormat.Hm('ru').format(DateTime(2024, 1, 1, hour, minute));
}

String formatShortDate(DateTime date) {
  return DateFormat('d MMM', 'ru').format(date);
}

String formatWeekday(DateTime date) {
  final value = DateFormat('EE', 'ru').format(date);
  if (value.isEmpty) {
    return '';
  }
  return '${value[0].toUpperCase()}${value.substring(1)}';
}

TimeOfDay? nullableTimeOfDay(int? hour, int? minute) {
  if (hour == null || minute == null) {
    return null;
  }
  return TimeOfDay(hour: hour, minute: minute);
}
