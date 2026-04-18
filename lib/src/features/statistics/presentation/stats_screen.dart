import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/empty_state_card.dart';
import '../../achievements/domain/achievement_models.dart';
import '../../achievements/domain/achievement_repository.dart';
import '../../profile/domain/profile_models.dart';
import '../../profile/domain/progress_repository.dart';
import '../../statistics/domain/daily_progress.dart';

class StatsState extends Equatable {
  const StatsState({
    required this.isLoading,
    required this.progress,
    required this.weeklyProgress,
    required this.achievements,
  });

  const StatsState.initial()
      : isLoading = true,
        progress = const UserProgress.empty(),
        weeklyProgress = const [],
        achievements = const [];

  final bool isLoading;
  final UserProgress progress;
  final List<DailyProgress> weeklyProgress;
  final List<Achievement> achievements;

  StatsState copyWith({
    bool? isLoading,
    UserProgress? progress,
    List<DailyProgress>? weeklyProgress,
    List<Achievement>? achievements,
  }) {
    return StatsState(
      isLoading: isLoading ?? this.isLoading,
      progress: progress ?? this.progress,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      achievements: achievements ?? this.achievements,
    );
  }

  @override
  List<Object?> get props => [isLoading, progress, weeklyProgress, achievements];
}

class StatsCubit extends Cubit<StatsState> {
  StatsCubit({
    required ProgressRepository progressRepository,
    required AchievementRepository achievementRepository,
  })  : _progressRepository = progressRepository,
        _achievementRepository = achievementRepository,
        super(const StatsState.initial());

  final ProgressRepository _progressRepository;
  final AchievementRepository _achievementRepository;

  StreamSubscription<UserProgress>? _progressSubscription;
  StreamSubscription<List<DailyProgress>>? _weeklySubscription;
  StreamSubscription<List<Achievement>>? _achievementSubscription;

  UserProgress _progress = const UserProgress.empty();
  List<DailyProgress> _weeklyProgress = const [];
  List<Achievement> _achievements = const [];

  void start() {
    _progressSubscription = _progressRepository.watchProgress().listen((progress) {
      _progress = progress;
      _emitState();
    });
    _weeklySubscription =
        _progressRepository.watchWeeklySummary().listen((weeklyProgress) {
      _weeklyProgress = weeklyProgress;
      _emitState();
    });
    _achievementSubscription =
        _achievementRepository.watchAchievements().listen((achievements) {
      _achievements = achievements;
      _emitState();
    });
  }

  void _emitState() {
    emit(
      state.copyWith(
        isLoading: false,
        progress: _progress,
        weeklyProgress: _weeklyProgress,
        achievements: _achievements,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _progressSubscription?.cancel();
    await _weeklySubscription?.cancel();
    await _achievementSubscription?.cancel();
    return super.close();
  }
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsCubit, StatsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final unlockedCount = state.achievements.where((item) => item.isUnlocked).length;
        final weeklyCompletionRate = state.weeklyProgress.isEmpty
            ? 0.0
            : state.weeklyProgress
                    .map((day) => day.completionRate)
                    .fold<double>(0, (sum, rate) => sum + rate) /
                state.weeklyProgress.length;

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          children: [
            Text(
              'Неделя прогресса',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Как проходит текущая неделя',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    if (state.weeklyProgress.isEmpty)
                      const EmptyStateCard(
                        title: 'Пока нет данных',
                        description: 'Когда начнешь отмечать привычки, здесь появится динамика.',
                        icon: Icons.bar_chart_rounded,
                      )
                    else
                      SizedBox(
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: state.weeklyProgress.map((day) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${day.completedCount}/${day.plannedCount}',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: double.infinity,
                                          height: 140 * day.completionRate.clamp(0.08, 1),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            gradient: const LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Color(0xFF0F766E),
                                                Color(0xFF67E8F9),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      formatWeekday(day.date),
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: const Color(0xFF475569),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _StatsCard(
                    title: 'XP всего',
                    value: '${state.progress.totalXp}',
                    caption: 'накоплено',
                    accent: const Color(0xFFF59E0B),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatsCard(
                    title: 'Процент недели',
                    value: '${(weeklyCompletionRate * 100).round()}%',
                    caption: 'среднее выполнение',
                    accent: const Color(0xFF14B8A6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatsCard(
                    title: 'Достижения',
                    value: '$unlockedCount',
                    caption: 'разблокировано',
                    accent: const Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Игровые вехи',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (state.achievements.isEmpty)
              const EmptyStateCard(
                title: 'Достижения еще не готовы',
                description: 'Инициализация достижений произойдет автоматически.',
                icon: Icons.workspace_premium_outlined,
              )
            else
              ...state.achievements.map(
                (achievement) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                achievement.isUnlocked
                                    ? Icons.emoji_events_rounded
                                    : Icons.lock_clock_outlined,
                                color: achievement.isUnlocked
                                    ? const Color(0xFFF59E0B)
                                    : const Color(0xFF94A3B8),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  achievement.title,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              Text(
                                '${achievement.progress}/${achievement.threshold}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            achievement.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF475569),
                                ),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: achievement.progressFraction,
                              minHeight: 8,
                              backgroundColor: const Color(0xFFE2E8F0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.title,
    required this.value,
    required this.caption,
    required this.accent,
  });

  final String title;
  final String value;
  final String caption;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: accent,
                  ),
            ),
            const SizedBox(height: 6),
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
