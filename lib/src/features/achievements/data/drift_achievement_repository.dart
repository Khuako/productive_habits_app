import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../domain/achievement_models.dart';
import '../domain/achievement_repository.dart';
import 'achievement_definitions.dart';

class DriftAchievementRepository implements AchievementRepository {
  DriftAchievementRepository(this._database);

  final AppDatabase _database;

  @override
  Future<void> ensureSeeded() async {
    final existing = await _database.select(_database.achievementEntries).get();
    final existingKeys = existing.map((row) => row.key).toSet();

    for (final definition in AchievementDefinitions.all) {
      if (existingKeys.contains(definition.key)) {
        continue;
      }
      await _database.into(_database.achievementEntries).insert(
            AchievementEntriesCompanion.insert(
              key: definition.key,
              progress: const Value(0),
            ),
          );
    }
  }

  @override
  Stream<List<Achievement>> watchAchievements() {
    return (_database.select(_database.achievementEntries)
          ..orderBy([
            (entry) => OrderingTerm.asc(entry.key),
          ]))
        .watch()
        .map(
          (rows) => rows
              .map((row) => _mapAchievement(row))
              .toList()
            ..sort((a, b) => _sortIndex(a.key).compareTo(_sortIndex(b.key))),
        );
  }

  Achievement _mapAchievement(AchievementEntry row) {
    final definition = AchievementDefinitions.byKey[row.key]!;
    return Achievement(
      key: row.key,
      title: definition.title,
      description: definition.description,
      iconName: definition.iconName,
      threshold: definition.threshold,
      progress: row.progress,
      unlockedAt: row.unlockedAt,
    );
  }

  int _sortIndex(String key) {
    return AchievementDefinitions.all.indexWhere((definition) => definition.key == key);
  }
}
