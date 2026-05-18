import 'recovery_models.dart';

abstract class RecoveryRepository {
  Stream<RecoveryDayState?> watchTodayState();

  Stream<List<RecoveryHistoryEntry>> watchRecoveryHistory({int days = 30});

  Stream<WeeklyRecoveryReview> watchWeeklyReview({int days = 7});

  Stream<RecoveryInsight> watchDifficultPeriodInsight({int days = 14});

  Future<RecoveryDayState?> getTodayState();

  Future<void> submitDailyCheckIn(DailyCheckInDraft draft);

  Future<void> acceptLightPlan(String dayKey);
}
