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
import '../../recovery/domain/recovery_models.dart';
import '../../recovery/domain/recovery_repository.dart';
import '../../statistics/domain/daily_progress.dart';

class StatsState extends Equatable {
  const StatsState({
    required this.isLoading,
    required this.progress,
    required this.weeklyProgress,
    required this.achievements,
    required this.recoveryHistory,
    required this.weeklyRecoveryReview,
    required this.recoveryInsight,
  });

  const StatsState.initial()
      : isLoading = true,
        progress = const UserProgress.empty(),
        weeklyProgress = const [],
        achievements = const [],
        recoveryHistory = const [],
        weeklyRecoveryReview = const WeeklyRecoveryReview.empty(),
        recoveryInsight = const RecoveryInsight.empty();

  final bool isLoading;
  final UserProgress progress;
  final List<DailyProgress> weeklyProgress;
  final List<Achievement> achievements;
  final List<RecoveryHistoryEntry> recoveryHistory;
  final WeeklyRecoveryReview weeklyRecoveryReview;
  final RecoveryInsight recoveryInsight;

  StatsState copyWith({
    bool? isLoading,
    UserProgress? progress,
    List<DailyProgress>? weeklyProgress,
    List<Achievement>? achievements,
    List<RecoveryHistoryEntry>? recoveryHistory,
    WeeklyRecoveryReview? weeklyRecoveryReview,
    RecoveryInsight? recoveryInsight,
  }) {
    return StatsState(
      isLoading: isLoading ?? this.isLoading,
      progress: progress ?? this.progress,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      achievements: achievements ?? this.achievements,
      recoveryHistory: recoveryHistory ?? this.recoveryHistory,
      weeklyRecoveryReview: weeklyRecoveryReview ?? this.weeklyRecoveryReview,
      recoveryInsight: recoveryInsight ?? this.recoveryInsight,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        progress,
        weeklyProgress,
        achievements,
        recoveryHistory,
        weeklyRecoveryReview,
        recoveryInsight,
      ];
}

class StatsCubit extends Cubit<StatsState> {
  StatsCubit({
    required ProgressRepository progressRepository,
    required AchievementRepository achievementRepository,
    required RecoveryRepository recoveryRepository,
  })  : _progressRepository = progressRepository,
        _achievementRepository = achievementRepository,
        _recoveryRepository = recoveryRepository,
        super(const StatsState.initial());

  final ProgressRepository _progressRepository;
  final AchievementRepository _achievementRepository;
  final RecoveryRepository _recoveryRepository;

  StreamSubscription<UserProgress>? _progressSubscription;
  StreamSubscription<List<DailyProgress>>? _weeklySubscription;
  StreamSubscription<List<Achievement>>? _achievementSubscription;
  StreamSubscription<List<RecoveryHistoryEntry>>? _recoveryHistorySubscription;
  StreamSubscription<WeeklyRecoveryReview>? _recoveryReviewSubscription;
  StreamSubscription<RecoveryInsight>? _recoveryInsightSubscription;

  UserProgress _progress = const UserProgress.empty();
  List<DailyProgress> _weeklyProgress = const [];
  List<Achievement> _achievements = const [];
  List<RecoveryHistoryEntry> _recoveryHistory = const [];
  WeeklyRecoveryReview _weeklyRecoveryReview =
      const WeeklyRecoveryReview.empty();
  RecoveryInsight _recoveryInsight = const RecoveryInsight.empty();

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
    _recoveryHistorySubscription =
        _recoveryRepository.watchRecoveryHistory().listen((history) {
      _recoveryHistory = history;
      _emitState();
    });
    _recoveryReviewSubscription =
        _recoveryRepository.watchWeeklyReview().listen((review) {
      _weeklyRecoveryReview = review;
      _emitState();
    });
    _recoveryInsightSubscription =
        _recoveryRepository.watchDifficultPeriodInsight().listen((insight) {
      _recoveryInsight = insight;
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
        recoveryHistory: _recoveryHistory,
        weeklyRecoveryReview: _weeklyRecoveryReview,
        recoveryInsight: _recoveryInsight,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _progressSubscription?.cancel();
    await _weeklySubscription?.cancel();
    await _achievementSubscription?.cancel();
    await _recoveryHistorySubscription?.cancel();
    await _recoveryReviewSubscription?.cancel();
    await _recoveryInsightSubscription?.cancel();
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
              'Recovery review за неделю',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _WeeklyRecoveryReviewCard(review: state.weeklyRecoveryReview),
            const SizedBox(height: 18),
            Text(
              'Последние recovery-дни',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _RecoveryHistoryCard(history: state.recoveryHistory),
            const SizedBox(height: 18),
            Text(
              'Почему был сложный период',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _RecoveryInsightCard(insight: state.recoveryInsight),
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
                                '${achievement.displayProgress}/${achievement.threshold}',
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

class _WeeklyRecoveryReviewCard extends StatelessWidget {
  const _WeeklyRecoveryReviewCard({required this.review});

  final WeeklyRecoveryReview review;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Сколько было обычных, напряженных и recovery-дней',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            if (!review.hasData)
              const EmptyStateCard(
                title: 'Пока нет recovery-данных',
                description: 'Когда появятся check-in и recovery-статусы, здесь соберется обзор недели.',
                icon: Icons.favorite_border_rounded,
              )
            else ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _StatusPill(
                    label: 'Нормальные',
                    value: review.normalDays,
                    color: const Color(0xFF0F766E),
                  ),
                  _StatusPill(
                    label: 'Напряженные',
                    value: review.tenseDays,
                    color: const Color(0xFFF59E0B),
                  ),
                  _StatusPill(
                    label: 'Восстановление',
                    value: review.recoveryDays,
                    color: const Color(0xFFF97316),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _StatsCard(
                      title: 'Recovery-дни',
                      value: '${(review.recoveryCompletionRate * 100).round()}%',
                      caption: 'выполнение плана',
                      accent: const Color(0xFFF97316),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatsCard(
                      title: 'Обычные дни',
                      value: '${(review.regularCompletionRate * 100).round()}%',
                      caption: 'выполнение плана',
                      accent: const Color(0xFF0F766E),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RecoveryHistoryCard extends StatelessWidget {
  const _RecoveryHistoryCard({required this.history});

  final List<RecoveryHistoryEntry> history;

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const EmptyStateCard(
        title: 'Recovery-дней пока не было',
        description: 'История появится после первых дней восстановления.',
        icon: Icons.history_toggle_off_rounded,
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: history.take(5).map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: entry.lightPlanAccepted
                          ? const Color(0xFF16A34A)
                          : const Color(0xFFF97316),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatShortDate(entry.date),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.reasons.isEmpty
                              ? entry.status.summary
                              : entry.reasons.join(' • '),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF475569),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.lightPlanAccepted ? 'План принят' : 'План не принят',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _RecoveryInsightCard extends StatelessWidget {
  const _RecoveryInsightCard({required this.insight});

  final RecoveryInsight insight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              insight.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF475569),
                  ),
            ),
            if (!insight.hasData) ...[
              const SizedBox(height: 16),
              const EmptyStateCard(
                title: 'Пока выводов мало',
                description: 'Нужно несколько recovery или tense-дней, чтобы собрать повторяющиеся причины.',
                icon: Icons.lightbulb_outline_rounded,
              ),
            ] else ...[
              const SizedBox(height: 16),
              for (final item in insight.explanations)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(
                          Icons.circle,
                          size: 8,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF475569),
                ),
          ),
        ],
      ),
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
