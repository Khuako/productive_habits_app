import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/reminder_service.dart';
import '../../../core/widgets/empty_state_card.dart';
import '../../habits/domain/habit_repository.dart';
import '../../profile/domain/profile_models.dart';
import '../../profile/domain/progress_repository.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.isLoading,
    required this.profile,
    required this.progress,
    required this.isRequestingPermission,
  });

  const ProfileState.initial()
      : isLoading = true,
        profile = null,
        progress = const UserProgress.empty(),
        isRequestingPermission = false;

  final bool isLoading;
  final UserProfile? profile;
  final UserProgress progress;
  final bool isRequestingPermission;

  ProfileState copyWith({
    bool? isLoading,
    UserProfile? profile,
    UserProgress? progress,
    bool? isRequestingPermission,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      progress: progress ?? this.progress,
      isRequestingPermission:
          isRequestingPermission ?? this.isRequestingPermission,
    );
  }

  @override
  List<Object?> get props => [isLoading, profile, progress, isRequestingPermission];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProgressRepository progressRepository,
    required HabitRepository habitRepository,
    required ReminderService reminderService,
  })  : _progressRepository = progressRepository,
        _habitRepository = habitRepository,
        _reminderService = reminderService,
        super(const ProfileState.initial());

  final ProgressRepository _progressRepository;
  final HabitRepository _habitRepository;
  final ReminderService _reminderService;

  StreamSubscription<UserProfile?>? _profileSubscription;
  StreamSubscription<UserProgress>? _progressSubscription;

  UserProfile? _profile;
  UserProgress _progress = const UserProgress.empty();

  void start() {
    _profileSubscription = _progressRepository.watchUserProfile().listen((profile) {
      _profile = profile;
      _emit();
    });
    _progressSubscription = _progressRepository.watchProgress().listen((progress) {
      _progress = progress;
      _emit();
    });
    unawaited(_syncPermissionState());
  }

  Future<void> requestNotifications() async {
    emit(state.copyWith(isRequestingPermission: true));
    final granted = await _reminderService.requestPermissions();
    final timeZone = await _reminderService.getLocalTimeZone();
    await _progressRepository.updateNotifications(enabled: granted, timeZone: timeZone);
    if (granted) {
      await _habitRepository.syncAllReminders();
    }
    emit(state.copyWith(isRequestingPermission: false));
  }

  Future<void> _syncPermissionState() async {
    final enabled = await _reminderService.areNotificationsEnabled();
    final timeZone = await _reminderService.getLocalTimeZone();
    await _progressRepository.updateNotifications(enabled: enabled, timeZone: timeZone);
  }

  void _emit() {
    emit(
      state.copyWith(
        isLoading: false,
        profile: _profile,
        progress: _progress,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _profileSubscription?.cancel();
    await _progressSubscription?.cancel();
    return super.close();
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = state.profile;
        if (profile == null || !profile.onboardingCompleted) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            children: const [
              EmptyStateCard(
                title: 'Профиль еще не настроен',
                description: 'Вернись к онбордингу, чтобы заполнить основные данные.',
                icon: Icons.person_outline_rounded,
              ),
            ],
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFFCCFBF1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Color(0xFF0F766E),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${profile.goal} • ${profile.routine}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFF475569),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: _ProfileMetric(
                            label: 'Уровень',
                            value: '${state.progress.level}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ProfileMetric(
                            label: 'XP',
                            value: '${state.progress.totalXp}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ProfileMetric(
                            label: 'Серия',
                            value: '${state.progress.currentStreak}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Уведомления',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profile.notificationsEnabled
                          ? 'Системные уведомления включены. Напоминания будут приходить по локальному расписанию.'
                          : 'Уведомления еще не включены. Приложение продолжит работать и без них, но напоминания не появятся.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF475569),
                          ),
                    ),
                    if (profile.timeZone != null && profile.timeZone!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Локальная timezone: ${profile.timeZone}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF64748B),
                            ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: state.isRequestingPermission
                          ? null
                          : () => context.read<ProfileCubit>().requestNotifications(),
                      icon: state.isRequestingPermission
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.notifications_active_rounded),
                      label: Text(
                        profile.notificationsEnabled
                            ? 'Проверить разрешение'
                            : 'Включить уведомления',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Режим проекта',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'MVP полностью оффлайн. Без облака, без аккаунтов и без внешних API. Это безопасный демонстрационный контур для курсовой.',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Задел под магистерскую: персонализированные рекомендации, адаптивные напоминания и более умная аналитика поверх уже существующих моделей.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileMetric extends StatelessWidget {
  const _ProfileMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF64748B),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
