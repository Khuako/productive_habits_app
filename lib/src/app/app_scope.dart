import '../core/services/flutter_reminder_service.dart';
import '../core/services/reminder_service.dart';
import '../data/local/app_database.dart';
import '../features/achievements/data/drift_achievement_repository.dart';
import '../features/achievements/domain/achievement_repository.dart';
import '../features/habits/data/drift_habit_repository.dart';
import '../features/habits/data/local_recommendation_engine.dart';
import '../features/habits/domain/habit_repository.dart';
import '../features/profile/data/drift_progress_repository.dart';
import '../features/profile/domain/progress_repository.dart';
import '../features/recovery/data/drift_recovery_repository.dart';
import '../features/recovery/domain/recovery_repository.dart';
import '../features/recovery/domain/recovery_rule_engine.dart';
import 'app_status_cubit.dart';

class AppScope {
  AppScope({
    required this.database,
    required this.habitRepository,
    required this.progressRepository,
    required this.achievementRepository,
    required this.recoveryRepository,
    required this.recommendationEngine,
    required this.reminderService,
    required this.appStatusCubit,
  });

  final AppDatabase database;
  final HabitRepository habitRepository;
  final ProgressRepository progressRepository;
  final AchievementRepository achievementRepository;
  final RecoveryRepository recoveryRepository;
  final RecommendationEngine recommendationEngine;
  final ReminderService reminderService;
  final AppStatusCubit appStatusCubit;
  bool _disposed = false;

  static Future<AppScope> bootstrap() async {
    final database = AppDatabase();
    final reminderService = FlutterReminderService();
    await reminderService.initialize();

    final achievementRepository = DriftAchievementRepository(database);
    await achievementRepository.ensureSeeded();

    final progressRepository = DriftProgressRepository(
      database: database,
      achievementRepository: achievementRepository,
    );
    await progressRepository.ensureDefaults();
    await progressRepository.refreshDerivedState();

    final habitRepository = DriftHabitRepository(
      database: database,
      progressRepository: progressRepository,
      reminderService: reminderService,
    );
    await habitRepository.syncAllReminders();

    final recoveryRepository = DriftRecoveryRepository(
      database: database,
      ruleEngine: const RecoveryRuleEngine(),
    );

    final appStatusCubit = AppStatusCubit(progressRepository)..start();

    return AppScope(
      database: database,
      habitRepository: habitRepository,
      progressRepository: progressRepository,
      achievementRepository: achievementRepository,
      recoveryRepository: recoveryRepository,
      recommendationEngine: LocalRecommendationEngine(),
      reminderService: reminderService,
      appStatusCubit: appStatusCubit,
    );
  }

  Future<void> dispose() async {
    if (_disposed) {
      return;
    }
    _disposed = true;
    await appStatusCubit.close();
    await reminderService.dispose();
    await database.close();
  }
}
