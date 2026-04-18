import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/date_utils.dart';
import '../../../core/utils/habit_style.dart';
import '../domain/habit_models.dart';
import '../domain/habit_repository.dart';

class HabitFormScreen extends StatefulWidget {
  const HabitFormScreen({
    this.habitId,
    super.key,
  });

  final int? habitId;

  @override
  State<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends State<HabitFormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  var _isLoading = false;
  var _isSaving = false;
  var _category = HabitStyle.categories.first;
  var _difficulty = 2;
  var _priority = 2;
  var _weekdays = <int>{1, 2, 3, 4, 5};
  var _reminderEnabled = true;
  TimeOfDay? _time = const TimeOfDay(hour: 9, minute: 0);

  bool get _isEdit => widget.habitId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      _loadHabit();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadHabit() async {
    setState(() => _isLoading = true);
    final repository = context.read<HabitRepository>();
    final habit = await repository.getHabitById(widget.habitId!);
    if (habit != null && mounted) {
      _titleController.text = habit.title;
      _descriptionController.text = habit.description;
      _category = habit.category;
      _difficulty = habit.difficulty;
      _priority = habit.priority;
      _weekdays = habit.schedule.weekdays.toSet();
      _reminderEnabled = habit.schedule.reminderEnabled;
      _time = nullableTimeOfDay(
        habit.schedule.reminderHour,
        habit.schedule.reminderMinute,
      );
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _time ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (selected != null) {
      setState(() => _time = selected);
    }
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Добавь название привычки.')),
      );
      return;
    }
    if (_weekdays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выбери хотя бы один день недели.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    final repository = context.read<HabitRepository>();
    final draft = HabitDraft(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _category,
      difficulty: _difficulty,
      priority: _priority,
      schedule: HabitSchedule(
        weekdays: _weekdays.toList()..sort(),
        reminderEnabled: _reminderEnabled,
        reminderHour: _reminderEnabled ? _time?.hour : null,
        reminderMinute: _reminderEnabled ? _time?.minute : null,
      ),
    );

    if (_isEdit) {
      await repository.updateHabit(widget.habitId!, draft);
    } else {
      await repository.createHabit(draft);
    }

    if (mounted) {
      setState(() => _isSaving = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final xpReward = HabitStyle.xpForDifficulty(_difficulty);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Редактировать привычку' : 'Новая привычка'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: const Text('Сохранить'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Основное',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Название привычки',
                            hintText: 'Например, фокус-спринт перед учебой',
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Описание',
                            hintText: 'Что именно ты хочешь делать регулярно?',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Категория и сложность',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final category in HabitStyle.categories)
                              ChoiceChip(
                                label: Text(category),
                                selected: _category == category,
                                onSelected: (_) => setState(() => _category = category),
                              ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SegmentedButton<int>(
                          segments: const [
                            ButtonSegment(value: 1, label: Text('Легкая')),
                            ButtonSegment(value: 2, label: Text('Средняя')),
                            ButtonSegment(value: 3, label: Text('Сложная')),
                          ],
                          selected: {_difficulty},
                          onSelectionChanged: (selection) {
                            setState(() => _difficulty = selection.first);
                          },
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Награда за выполнение: $xpReward XP',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF0F766E),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Приоритет в сложный день',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 10),
                        SegmentedButton<int>(
                          segments: const [
                            ButtonSegment(value: 1, label: Text('Гибкая')),
                            ButtonSegment(value: 2, label: Text('Важная')),
                            ButtonSegment(value: 3, label: Text('Ключевая')),
                          ],
                          selected: {_priority},
                          onSelectionChanged: (selection) {
                            setState(() => _priority = selection.first);
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Recovery-режим сохранит в фокусе в первую очередь ключевые привычки.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF64748B),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Расписание',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (var weekday = 1; weekday <= 7; weekday++)
                              FilterChip(
                                label: Text(shortWeekdayLabel(weekday)),
                                selected: _weekdays.contains(weekday),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _weekdays.add(weekday);
                                    } else {
                                      _weekdays.remove(weekday);
                                    }
                                  });
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Локальное напоминание'),
                          subtitle: const Text('Работает без интернета и внешних API.'),
                          value: _reminderEnabled,
                          onChanged: (value) => setState(() => _reminderEnabled = value),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _reminderEnabled ? _pickTime : null,
                          icon: const Icon(Icons.schedule_rounded),
                          label: Text(
                            _time == null
                                ? 'Выбрать время'
                                : 'Время: ${_time!.format(context)}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_rounded),
                  label: Text(_isEdit ? 'Сохранить изменения' : 'Создать привычку'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 54),
                  ),
                ),
              ],
            ),
    );
  }
}
