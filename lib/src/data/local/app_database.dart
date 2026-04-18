import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class UserProfiles extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().nullable()();
  TextColumn get goal => text().nullable()();
  TextColumn get routine => text().nullable()();
  BoolColumn get onboardingCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get timeZone => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class UserProgressEntries extends Table {
  IntColumn get id => integer()();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get bestStreak => integer().withDefault(const Constant(0))();
  IntColumn get completedToday => integer().withDefault(const Constant(0))();
  IntColumn get totalCompletions => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get category => text()();
  IntColumn get difficulty => integer()();
  IntColumn get priority => integer().withDefault(const Constant(2))();
  TextColumn get iconName => text()();
  IntColumn get colorValue => integer()();
  IntColumn get xpReward => integer()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class HabitSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id)();
  TextColumn get weekdays => text()();
  BoolColumn get reminderEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get reminderHour => integer().nullable()();
  IntColumn get reminderMinute => integer().nullable()();

  @override
  List<String> get customConstraints => ['UNIQUE(habit_id)'];
}

class HabitCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id)();
  TextColumn get dayKey => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get awardedXp => integer()();
  IntColumn get streakAfterCompletion => integer().withDefault(const Constant(0))();

  @override
  List<String> get customConstraints => ['UNIQUE(habit_id, day_key)'];
}

class AchievementEntries extends Table {
  TextColumn get key => text()();
  IntColumn get progress => integer().withDefault(const Constant(0))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class DailyCheckIns extends Table {
  TextColumn get dayKey => text()();
  IntColumn get energy => integer()();
  IntColumn get load => integer()();
  IntColumn get mood => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {dayKey};
}

class RecoveryDayEntries extends Table {
  TextColumn get dayKey => text()();
  TextColumn get status => text()();
  IntColumn get riskScore => integer().withDefault(const Constant(0))();
  TextColumn get reasons => text().withDefault(const Constant(''))();
  TextColumn get suggestedHabitIds => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {dayKey};
}

@DriftDatabase(
  tables: [
    UserProfiles,
    UserProgressEntries,
    Habits,
    HabitSchedules,
    HabitCompletions,
    AchievementEntries,
    DailyCheckIns,
    RecoveryDayEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(habits, habits.priority);
            await migrator.createTable(dailyCheckIns);
            await migrator.createTable(recoveryDayEntries);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final file = File(p.join(documentsDirectory.path, 'habit_quest.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
