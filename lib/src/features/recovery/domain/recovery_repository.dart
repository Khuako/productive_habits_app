import 'recovery_models.dart';

abstract class RecoveryRepository {
  Stream<RecoveryDayState?> watchTodayState();

  Future<RecoveryDayState?> getTodayState();

  Future<void> submitDailyCheckIn(DailyCheckInDraft draft);
}
