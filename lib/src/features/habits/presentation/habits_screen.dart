import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/habit_style.dart';
import '../../../core/widgets/empty_state_card.dart';
import '../domain/habit_models.dart';
import '../domain/habit_repository.dart';

class HabitsState extends Equatable {
  const HabitsState({
    required this.isLoading,
    required this.items,
  });

  const HabitsState.initial()
      : isLoading = true,
        items = const [];

  final bool isLoading;
  final List<HabitItem> items;

  HabitsState copyWith({
    bool? isLoading,
    List<HabitItem>? items,
  }) {
    return HabitsState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [isLoading, items];
}

class HabitsCubit extends Cubit<HabitsState> {
  HabitsCubit({
    required HabitRepository habitRepository,
  })  : _habitRepository = habitRepository,
        super(const HabitsState.initial());

  final HabitRepository _habitRepository;
  StreamSubscription<List<HabitItem>>? _subscription;

  void start() {
    _subscription?.cancel();
    emit(const HabitsState.initial());
    _subscription = _habitRepository.watchAllHabits().listen(
      (items) => emit(
        state.copyWith(
          isLoading: false,
          items: items,
        ),
      ),
    );
  }

  Future<void> toggleCompletion(int habitId) {
    return _habitRepository.toggleCompletion(habitId);
  }

  Future<void> archiveHabit(int habitId) {
    return _habitRepository.archiveHabit(habitId);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.items.isEmpty) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            children: [
              EmptyStateCard(
                title: 'Пока нет привычек',
                description: 'Создай первую привычку и начни собирать XP уже сегодня.',
                action: FilledButton(
                  onPressed: () => context.push('/habit/new'),
                  child: const Text('Создать привычку'),
                ),
              ),
            ],
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          itemCount: state.items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final item = state.items[index];
            final visual = HabitStyle.byCategory(item.habit.category);

            return Card(
              child: InkWell(
                onTap: () => context.push('/habit/${item.habit.id}/edit'),
                borderRadius: BorderRadius.circular(28),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(item.habit.colorValue).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              HabitStyle.iconFromKey(item.habit.iconName),
                              color: visual.color,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.habit.title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.subtitle,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: const Color(0xFF475569),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'edit') {
                                context.push('/habit/${item.habit.id}/edit');
                              } else if (value == 'archive') {
                                await context.read<HabitsCubit>().archiveHabit(item.habit.id);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Редактировать'),
                              ),
                              PopupMenuItem(
                                value: 'archive',
                                child: Text('Архивировать'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (item.habit.description.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          item.habit.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _Tag(
                            label: priorityLabel(item.habit.priority),
                            background: const Color(0xFFF1F5F9),
                            foreground: const Color(0xFF475569),
                          ),
                          _Tag(
                            label: HabitStyle.difficultyLabel(item.habit.difficulty),
                            background: const Color(0xFFF8FAFC),
                            foreground: const Color(0xFF334155),
                          ),
                          _Tag(
                            label: item.scheduledToday ? 'Сегодня в плане' : 'Не на сегодня',
                            background: item.scheduledToday
                                ? const Color(0xFFECFEFF)
                                : const Color(0xFFF8FAFC),
                            foreground: item.scheduledToday
                                ? const Color(0xFF0F766E)
                                : const Color(0xFF64748B),
                          ),
                          _Tag(
                            label: item.completedToday ? 'Выполнено' : 'Ожидает',
                            background: item.completedToday
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFFFF7ED),
                            foreground: item.completedToday
                                ? const Color(0xFF15803D)
                                : const Color(0xFFEA580C),
                          ),
                        ],
                      ),
                      if (item.scheduledToday) ...[
                        const SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton.icon(
                            onPressed: () =>
                                context.read<HabitsCubit>().toggleCompletion(item.habit.id),
                            icon: Icon(
                              item.completedToday
                                  ? Icons.undo_rounded
                                  : Icons.check_rounded,
                            ),
                            label: Text(
                              item.completedToday ? 'Отменить отметку' : 'Отметить',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
