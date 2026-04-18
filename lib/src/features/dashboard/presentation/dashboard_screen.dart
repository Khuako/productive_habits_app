import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/date_utils.dart';
import '../../../core/utils/habit_style.dart';
import '../../../core/widgets/empty_state_card.dart';
import '../../achievements/domain/achievement_models.dart';
import '../../achievements/domain/achievement_repository.dart';
import '../../habits/domain/habit_models.dart';
import '../../habits/domain/habit_repository.dart';
import '../../profile/domain/profile_models.dart';
import '../../profile/domain/progress_repository.dart';
import '../../recovery/domain/recovery_models.dart';
import '../../recovery/domain/recovery_repository.dart';
import '../../recovery/presentation/daily_check_in_sheet.dart';

class DashboardState extends Equatable {
  const DashboardState({
    required this.isLoading,
    required this.todayHabits,
    required this.progress,
    required this.profile,
    required this.achievements,
    required this.recoveryState,
    required this.nextReminderLabel,
  });

  const DashboardState.initial()
      : isLoading = true,
        todayHabits = const [],
        progress = const UserProgress.empty(),
        profile = null,
        achievements = const [],
        recoveryState = null,
        nextReminderLabel = null;

  final bool isLoading;
  final List<HabitItem> todayHabits;
  final UserProgress progress;
  final UserProfile? profile;
  final List<Achievement> achievements;
  final RecoveryDayState? recoveryState;
  final String? nextReminderLabel;

  DashboardState copyWith({
    bool? isLoading,
    List<HabitItem>? todayHabits,
    UserProgress? progress,
    UserProfile? profile,
    List<Achievement>? achievements,
    RecoveryDayState? recoveryState,
    String? nextReminderLabel,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      todayHabits: todayHabits ?? this.todayHabits,
      progress: progress ?? this.progress,
      profile: profile ?? this.profile,
      achievements: achievements ?? this.achievements,
      recoveryState: recoveryState ?? this.recoveryState,
      nextReminderLabel: nextReminderLabel ?? this.nextReminderLabel,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        todayHabits,
        progress,
        profile,
        achievements,
        recoveryState,
        nextReminderLabel,
      ];
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required HabitRepository habitRepository,
    required ProgressRepository progressRepository,
    required AchievementRepository achievementRepository,
    required RecoveryRepository recoveryRepository,
  })  : _habitRepository = habitRepository,
        _progressRepository = progressRepository,
        _achievementRepository = achievementRepository,
        _recoveryRepository = recoveryRepository,
        super(const DashboardState.initial());

  final HabitRepository _habitRepository;
  final ProgressRepository _progressRepository;
  final AchievementRepository _achievementRepository;
  final RecoveryRepository _recoveryRepository;

  StreamSubscription<List<HabitItem>>? _habitSubscription;
  StreamSubscription<UserProgress>? _progressSubscription;
  StreamSubscription<UserProfile?>? _profileSubscription;
  StreamSubscription<List<Achievement>>? _achievementSubscription;
  StreamSubscription<RecoveryDayState?>? _recoverySubscription;

  List<HabitItem> _todayHabits = const [];
  UserProgress _progress = const UserProgress.empty();
  UserProfile? _profile;
  List<Achievement> _achievements = const [];
  RecoveryDayState? _recoveryState;

  void start() {
    _habitSubscription?.cancel();
    _progressSubscription?.cancel();
    _profileSubscription?.cancel();
    _achievementSubscription?.cancel();
    _recoverySubscription?.cancel();

    _habitSubscription = _habitRepository.watchTodayHabits().listen((items) {
      _todayHabits = items;
      _emitState();
    });
    _progressSubscription = _progressRepository.watchProgress().listen((progress) {
      _progress = progress;
      _emitState();
    });
    _profileSubscription = _progressRepository.watchUserProfile().listen((profile) {
      _profile = profile;
      _emitState();
    });
    _achievementSubscription =
        _achievementRepository.watchAchievements().listen((achievements) {
      _achievements = achievements;
      _emitState();
    });
    _recoverySubscription = _recoveryRepository.watchTodayState().listen((state) {
      _recoveryState = state;
      _emitState();
    });
  }

  Future<void> toggleCompletion(int habitId) {
    return _habitRepository.toggleCompletion(habitId);
  }

  Future<void> submitDailyCheckIn(DailyCheckInDraft draft) {
    return _recoveryRepository.submitDailyCheckIn(draft);
  }

  void _emitState() {
    emit(
      state.copyWith(
        isLoading: false,
        todayHabits: _todayHabits,
        progress: _progress,
        profile: _profile,
        achievements: _achievements,
        recoveryState: _recoveryState,
        nextReminderLabel: _buildNextReminderLabel(_todayHabits),
      ),
    );
  }

  String? _buildNextReminderLabel(List<HabitItem> items) {
    DateTime? nextReminder;
    for (final item in items) {
      final schedule = item.habit.schedule;
      if (!schedule.reminderEnabled ||
          schedule.reminderHour == null ||
          schedule.reminderMinute == null) {
        continue;
      }

      for (final weekday in schedule.weekdays) {
        final candidate = nextOccurrenceForWeekday(
          from: DateTime.now(),
          weekday: weekday,
          hour: schedule.reminderHour!,
          minute: schedule.reminderMinute!,
        );
        if (nextReminder == null || candidate.isBefore(nextReminder)) {
          nextReminder = candidate;
        }
      }
    }

    if (nextReminder == null) {
      return null;
    }
    return '${formatWeekday(nextReminder)}, ${formatReminderTime(nextReminder.hour, nextReminder.minute)}';
  }

  @override
  Future<void> close() async {
    await _habitSubscription?.cancel();
    await _progressSubscription?.cancel();
    await _profileSubscription?.cancel();
    await _achievementSubscription?.cancel();
    await _recoverySubscription?.cancel();
    return super.close();
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final suggestedFocus = state.recoveryState?.suggestedHabitIds.isEmpty ?? true
            ? const <HabitItem>[]
            : state.todayHabits
                .where(
                  (item) => state.recoveryState!.suggestedHabitIds.contains(item.habit.id),
                )
                .toList();

        final greeting = state.profile?.name.isNotEmpty == true
            ? 'Привет, ${state.profile!.name}'
            : 'Привет';

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0F766E),
                    Color(0xFF14B8A6),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Сегодня у тебя ${state.todayHabits.length} привыч${_pluralizeHabit(state.todayHabits.length)} в плане',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.nextReminderLabel == null
                        ? 'Напоминания пока не настроены или уже на сегодня завершены.'
                        : 'Ближайшее напоминание: ${state.nextReminderLabel}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                  ),
                  const SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: state.progress.levelProgress,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFFDE68A)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Уровень ${state.progress.level} • ${state.progress.totalXp} XP',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            if (state.recoveryState == null)
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _MorningCheckInCard(
                  onTap: () => _openDailyCheckIn(context),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _RecoveryStatusCard(
                  recoveryState: state.recoveryState!,
                  suggestedFocus: suggestedFocus,
                  onRetake: () => _openDailyCheckIn(context),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: 'Серия',
                    value: '${state.progress.currentStreak}',
                    caption: 'дней подряд',
                    accent: const Color(0xFFFB923C),
                    icon: Icons.local_fire_department_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    title: 'Сегодня',
                    value: '${state.progress.completedToday}',
                    caption: 'отмечено',
                    accent: const Color(0xFF22C55E),
                    icon: Icons.task_alt_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    title: 'Лучшее',
                    value: '${state.progress.bestStreak}',
                    caption: 'лучший ритм',
                    accent: const Color(0xFF6366F1),
                    icon: Icons.insights_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/habits'),
                    icon: const Icon(Icons.checklist_rounded),
                    label: const Text('К списку привычек'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => context.push('/habit/new'),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Добавить'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Сегодняшний фокус',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (state.todayHabits.isEmpty)
              const EmptyStateCard(
                title: 'На сегодня все свободно',
                description:
                    'Добавь привычку с расписанием на сегодня, чтобы увидеть ее здесь.',
                icon: Icons.spa_rounded,
              )
            else
              ...state.todayHabits.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TodayHabitTile(item: item),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              'Достижения',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (state.achievements.isEmpty)
              const EmptyStateCard(
                title: 'Достижения еще не инициализированы',
                description: 'После первых действий появятся игровые вехи.',
                icon: Icons.emoji_events_outlined,
              )
            else
              ...state.achievements.take(3).map(
                (achievement) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _AchievementPreview(achievement: achievement),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _openDailyCheckIn(BuildContext context) async {
    final draft = await showDailyCheckInSheet(context);
    if (draft == null || !context.mounted) {
      return;
    }
    await context.read<DashboardCubit>().submitDailyCheckIn(draft);
  }

  String _pluralizeHabit(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return 'ка';
    }
    if ([2, 3, 4].contains(count % 10) &&
        ![12, 13, 14].contains(count % 100)) {
      return 'ки';
    }
    return 'ек';
  }
}

class _MorningCheckInCard extends StatelessWidget {
  const _MorningCheckInCard({required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Утренний check-in',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Оцени энергию, нагрузку и настроение. Это поможет подобрать мягкий ритм на сегодня.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF475569),
                  ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.wb_sunny_outlined),
              label: const Text('Сделать check-in'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecoveryStatusCard extends StatelessWidget {
  const _RecoveryStatusCard({
    required this.recoveryState,
    required this.suggestedFocus,
    required this.onRetake,
  });

  final RecoveryDayState recoveryState;
  final List<HabitItem> suggestedFocus;
  final Future<void> Function() onRetake;

  @override
  Widget build(BuildContext context) {
    final accent = switch (recoveryState.status) {
      RecoveryDayStatus.normal => const Color(0xFF0F766E),
      RecoveryDayStatus.tense => const Color(0xFFF59E0B),
      RecoveryDayStatus.recovery => const Color(0xFFF97316),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    recoveryState.status == RecoveryDayStatus.normal
                        ? Icons.bolt_rounded
                        : Icons.favorite_border_rounded,
                    color: accent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recoveryState.status.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recoveryState.status.summary,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF475569),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (recoveryState.reasons.isNotEmpty) ...[
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final reason in recoveryState.reasons)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        reason,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ],
            if (suggestedFocus.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Облегченный фокус на сегодня',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              for (final item in suggestedFocus)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 18,
                        color: Color(0xFF0F766E),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.habit.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onRetake,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Обновить check-in'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.caption,
    required this.accent,
    required this.icon,
  });

  final String title;
  final String value;
  final String caption;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accent),
            const SizedBox(height: 14),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              caption,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayHabitTile extends StatelessWidget {
  const _TodayHabitTile({required this.item});

  final HabitItem item;

  @override
  Widget build(BuildContext context) {
    final visual = HabitStyle.byCategory(item.habit.category);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(item.habit.colorValue).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
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
            const SizedBox(width: 8),
            IconButton.filledTonal(
              onPressed: () => context.read<DashboardCubit>().toggleCompletion(item.habit.id),
              icon: Icon(
                item.completedToday ? Icons.undo_rounded : Icons.check_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementPreview extends StatelessWidget {
  const _AchievementPreview({required this.achievement});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement.isUnlocked;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: unlocked ? const Color(0xFFFEF3C7) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                unlocked ? Icons.emoji_events_rounded : Icons.workspace_premium_outlined,
                color: unlocked ? const Color(0xFFD97706) : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    achievement.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF475569),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${achievement.progress}/${achievement.threshold}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: unlocked ? const Color(0xFFD97706) : const Color(0xFF475569),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
