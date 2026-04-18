import 'achievement_models.dart';

abstract class AchievementRepository {
  Future<void> ensureSeeded();

  Stream<List<Achievement>> watchAchievements();
}
