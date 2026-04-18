import '../../statistics/domain/daily_progress.dart';
import 'profile_models.dart';

abstract class ProgressRepository {
  Future<void> ensureDefaults();

  Stream<UserProfile?> watchUserProfile();

  Future<UserProfile?> getUserProfile();

  Future<void> saveProfile(UserProfileDraft draft);

  Stream<UserProgress> watchProgress();

  Stream<List<DailyProgress>> watchWeeklySummary({int days = 7});

  Future<void> refreshDerivedState();

  Future<void> updateNotifications({
    required bool enabled,
    String? timeZone,
  });
}
