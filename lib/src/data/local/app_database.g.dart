// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routineMeta = const VerificationMeta(
    'routine',
  );
  @override
  late final GeneratedColumn<String> routine = GeneratedColumn<String>(
    'routine',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _timeZoneMeta = const VerificationMeta(
    'timeZone',
  );
  @override
  late final GeneratedColumn<String> timeZone = GeneratedColumn<String>(
    'time_zone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    goal,
    routine,
    onboardingCompleted,
    notificationsEnabled,
    timeZone,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    }
    if (data.containsKey('routine')) {
      context.handle(
        _routineMeta,
        routine.isAcceptableOrUnknown(data['routine']!, _routineMeta),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('time_zone')) {
      context.handle(
        _timeZoneMeta,
        timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      ),
      routine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine'],
      ),
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      timeZone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_zone'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String? name;
  final String? goal;
  final String? routine;
  final bool onboardingCompleted;
  final bool notificationsEnabled;
  final String? timeZone;
  final DateTime? createdAt;
  const UserProfile({
    required this.id,
    this.name,
    this.goal,
    this.routine,
    required this.onboardingCompleted,
    required this.notificationsEnabled,
    this.timeZone,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || goal != null) {
      map['goal'] = Variable<String>(goal);
    }
    if (!nullToAbsent || routine != null) {
      map['routine'] = Variable<String>(routine);
    }
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    if (!nullToAbsent || timeZone != null) {
      map['time_zone'] = Variable<String>(timeZone);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      goal: goal == null && nullToAbsent ? const Value.absent() : Value(goal),
      routine: routine == null && nullToAbsent
          ? const Value.absent()
          : Value(routine),
      onboardingCompleted: Value(onboardingCompleted),
      notificationsEnabled: Value(notificationsEnabled),
      timeZone: timeZone == null && nullToAbsent
          ? const Value.absent()
          : Value(timeZone),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      goal: serializer.fromJson<String?>(json['goal']),
      routine: serializer.fromJson<String?>(json['routine']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      timeZone: serializer.fromJson<String?>(json['timeZone']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'goal': serializer.toJson<String?>(goal),
      'routine': serializer.toJson<String?>(routine),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'timeZone': serializer.toJson<String?>(timeZone),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  UserProfile copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    Value<String?> goal = const Value.absent(),
    Value<String?> routine = const Value.absent(),
    bool? onboardingCompleted,
    bool? notificationsEnabled,
    Value<String?> timeZone = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => UserProfile(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    goal: goal.present ? goal.value : this.goal,
    routine: routine.present ? routine.value : this.routine,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    timeZone: timeZone.present ? timeZone.value : this.timeZone,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      goal: data.goal.present ? data.goal.value : this.goal,
      routine: data.routine.present ? data.routine.value : this.routine,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('routine: $routine, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('timeZone: $timeZone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    goal,
    routine,
    onboardingCompleted,
    notificationsEnabled,
    timeZone,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.goal == this.goal &&
          other.routine == this.routine &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.timeZone == this.timeZone &&
          other.createdAt == this.createdAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> goal;
  final Value<String?> routine;
  final Value<bool> onboardingCompleted;
  final Value<bool> notificationsEnabled;
  final Value<String?> timeZone;
  final Value<DateTime?> createdAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.goal = const Value.absent(),
    this.routine = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.goal = const Value.absent(),
    this.routine = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? goal,
    Expression<String>? routine,
    Expression<bool>? onboardingCompleted,
    Expression<bool>? notificationsEnabled,
    Expression<String>? timeZone,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (goal != null) 'goal': goal,
      if (routine != null) 'routine': routine,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (timeZone != null) 'time_zone': timeZone,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<String?>? goal,
    Value<String?>? routine,
    Value<bool>? onboardingCompleted,
    Value<bool>? notificationsEnabled,
    Value<String?>? timeZone,
    Value<DateTime?>? createdAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      goal: goal ?? this.goal,
      routine: routine ?? this.routine,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      timeZone: timeZone ?? this.timeZone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (routine.present) {
      map['routine'] = Variable<String>(routine.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('routine: $routine, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('timeZone: $timeZone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserProgressEntriesTable extends UserProgressEntries
    with TableInfo<$UserProgressEntriesTable, UserProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bestStreakMeta = const VerificationMeta(
    'bestStreak',
  );
  @override
  late final GeneratedColumn<int> bestStreak = GeneratedColumn<int>(
    'best_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedTodayMeta = const VerificationMeta(
    'completedToday',
  );
  @override
  late final GeneratedColumn<int> completedToday = GeneratedColumn<int>(
    'completed_today',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCompletionsMeta = const VerificationMeta(
    'totalCompletions',
  );
  @override
  late final GeneratedColumn<int> totalCompletions = GeneratedColumn<int>(
    'total_completions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    totalXp,
    level,
    currentStreak,
    bestStreak,
    completedToday,
    totalCompletions,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProgressEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('best_streak')) {
      context.handle(
        _bestStreakMeta,
        bestStreak.isAcceptableOrUnknown(data['best_streak']!, _bestStreakMeta),
      );
    }
    if (data.containsKey('completed_today')) {
      context.handle(
        _completedTodayMeta,
        completedToday.isAcceptableOrUnknown(
          data['completed_today']!,
          _completedTodayMeta,
        ),
      );
    }
    if (data.containsKey('total_completions')) {
      context.handle(
        _totalCompletionsMeta,
        totalCompletions.isAcceptableOrUnknown(
          data['total_completions']!,
          _totalCompletionsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      bestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_streak'],
      )!,
      completedToday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_today'],
      )!,
      totalCompletions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_completions'],
      )!,
    );
  }

  @override
  $UserProgressEntriesTable createAlias(String alias) {
    return $UserProgressEntriesTable(attachedDatabase, alias);
  }
}

class UserProgressEntry extends DataClass
    implements Insertable<UserProgressEntry> {
  final int id;
  final int totalXp;
  final int level;
  final int currentStreak;
  final int bestStreak;
  final int completedToday;
  final int totalCompletions;
  const UserProgressEntry({
    required this.id,
    required this.totalXp,
    required this.level,
    required this.currentStreak,
    required this.bestStreak,
    required this.completedToday,
    required this.totalCompletions,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_xp'] = Variable<int>(totalXp);
    map['level'] = Variable<int>(level);
    map['current_streak'] = Variable<int>(currentStreak);
    map['best_streak'] = Variable<int>(bestStreak);
    map['completed_today'] = Variable<int>(completedToday);
    map['total_completions'] = Variable<int>(totalCompletions);
    return map;
  }

  UserProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return UserProgressEntriesCompanion(
      id: Value(id),
      totalXp: Value(totalXp),
      level: Value(level),
      currentStreak: Value(currentStreak),
      bestStreak: Value(bestStreak),
      completedToday: Value(completedToday),
      totalCompletions: Value(totalCompletions),
    );
  }

  factory UserProgressEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressEntry(
      id: serializer.fromJson<int>(json['id']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      level: serializer.fromJson<int>(json['level']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      bestStreak: serializer.fromJson<int>(json['bestStreak']),
      completedToday: serializer.fromJson<int>(json['completedToday']),
      totalCompletions: serializer.fromJson<int>(json['totalCompletions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalXp': serializer.toJson<int>(totalXp),
      'level': serializer.toJson<int>(level),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'bestStreak': serializer.toJson<int>(bestStreak),
      'completedToday': serializer.toJson<int>(completedToday),
      'totalCompletions': serializer.toJson<int>(totalCompletions),
    };
  }

  UserProgressEntry copyWith({
    int? id,
    int? totalXp,
    int? level,
    int? currentStreak,
    int? bestStreak,
    int? completedToday,
    int? totalCompletions,
  }) => UserProgressEntry(
    id: id ?? this.id,
    totalXp: totalXp ?? this.totalXp,
    level: level ?? this.level,
    currentStreak: currentStreak ?? this.currentStreak,
    bestStreak: bestStreak ?? this.bestStreak,
    completedToday: completedToday ?? this.completedToday,
    totalCompletions: totalCompletions ?? this.totalCompletions,
  );
  UserProgressEntry copyWithCompanion(UserProgressEntriesCompanion data) {
    return UserProgressEntry(
      id: data.id.present ? data.id.value : this.id,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      level: data.level.present ? data.level.value : this.level,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      bestStreak: data.bestStreak.present
          ? data.bestStreak.value
          : this.bestStreak,
      completedToday: data.completedToday.present
          ? data.completedToday.value
          : this.completedToday,
      totalCompletions: data.totalCompletions.present
          ? data.totalCompletions.value
          : this.totalCompletions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressEntry(')
          ..write('id: $id, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('completedToday: $completedToday, ')
          ..write('totalCompletions: $totalCompletions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    totalXp,
    level,
    currentStreak,
    bestStreak,
    completedToday,
    totalCompletions,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressEntry &&
          other.id == this.id &&
          other.totalXp == this.totalXp &&
          other.level == this.level &&
          other.currentStreak == this.currentStreak &&
          other.bestStreak == this.bestStreak &&
          other.completedToday == this.completedToday &&
          other.totalCompletions == this.totalCompletions);
}

class UserProgressEntriesCompanion extends UpdateCompanion<UserProgressEntry> {
  final Value<int> id;
  final Value<int> totalXp;
  final Value<int> level;
  final Value<int> currentStreak;
  final Value<int> bestStreak;
  final Value<int> completedToday;
  final Value<int> totalCompletions;
  const UserProgressEntriesCompanion({
    this.id = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.completedToday = const Value.absent(),
    this.totalCompletions = const Value.absent(),
  });
  UserProgressEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.completedToday = const Value.absent(),
    this.totalCompletions = const Value.absent(),
  });
  static Insertable<UserProgressEntry> custom({
    Expression<int>? id,
    Expression<int>? totalXp,
    Expression<int>? level,
    Expression<int>? currentStreak,
    Expression<int>? bestStreak,
    Expression<int>? completedToday,
    Expression<int>? totalCompletions,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalXp != null) 'total_xp': totalXp,
      if (level != null) 'level': level,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (bestStreak != null) 'best_streak': bestStreak,
      if (completedToday != null) 'completed_today': completedToday,
      if (totalCompletions != null) 'total_completions': totalCompletions,
    });
  }

  UserProgressEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? totalXp,
    Value<int>? level,
    Value<int>? currentStreak,
    Value<int>? bestStreak,
    Value<int>? completedToday,
    Value<int>? totalCompletions,
  }) {
    return UserProgressEntriesCompanion(
      id: id ?? this.id,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      completedToday: completedToday ?? this.completedToday,
      totalCompletions: totalCompletions ?? this.totalCompletions,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (bestStreak.present) {
      map['best_streak'] = Variable<int>(bestStreak.value);
    }
    if (completedToday.present) {
      map['completed_today'] = Variable<int>(completedToday.value);
    }
    if (totalCompletions.present) {
      map['total_completions'] = Variable<int>(totalCompletions.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressEntriesCompanion(')
          ..write('id: $id, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('completedToday: $completedToday, ')
          ..write('totalCompletions: $totalCompletions')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpRewardMeta = const VerificationMeta(
    'xpReward',
  );
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
    'xp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    category,
    difficulty,
    priority,
    iconName,
    colorValue,
    xpReward,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    } else if (isInserting) {
      context.missing(_iconNameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(
        _xpRewardMeta,
        xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta),
      );
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      xpReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_reward'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String title;
  final String description;
  final String category;
  final int difficulty;
  final int priority;
  final String iconName;
  final int colorValue;
  final int xpReward;
  final bool isArchived;
  final DateTime createdAt;
  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.priority,
    required this.iconName,
    required this.colorValue,
    required this.xpReward,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['difficulty'] = Variable<int>(difficulty);
    map['priority'] = Variable<int>(priority);
    map['icon_name'] = Variable<String>(iconName);
    map['color_value'] = Variable<int>(colorValue);
    map['xp_reward'] = Variable<int>(xpReward);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      difficulty: Value(difficulty),
      priority: Value(priority),
      iconName: Value(iconName),
      colorValue: Value(colorValue),
      xpReward: Value(xpReward),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      priority: serializer.fromJson<int>(json['priority']),
      iconName: serializer.fromJson<String>(json['iconName']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'difficulty': serializer.toJson<int>(difficulty),
      'priority': serializer.toJson<int>(priority),
      'iconName': serializer.toJson<String>(iconName),
      'colorValue': serializer.toJson<int>(colorValue),
      'xpReward': serializer.toJson<int>(xpReward),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    int? difficulty,
    int? priority,
    String? iconName,
    int? colorValue,
    int? xpReward,
    bool? isArchived,
    DateTime? createdAt,
  }) => Habit(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    difficulty: difficulty ?? this.difficulty,
    priority: priority ?? this.priority,
    iconName: iconName ?? this.iconName,
    colorValue: colorValue ?? this.colorValue,
    xpReward: xpReward ?? this.xpReward,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      priority: data.priority.present ? data.priority.value : this.priority,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('priority: $priority, ')
          ..write('iconName: $iconName, ')
          ..write('colorValue: $colorValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    category,
    difficulty,
    priority,
    iconName,
    colorValue,
    xpReward,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.difficulty == this.difficulty &&
          other.priority == this.priority &&
          other.iconName == this.iconName &&
          other.colorValue == this.colorValue &&
          other.xpReward == this.xpReward &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> category;
  final Value<int> difficulty;
  final Value<int> priority;
  final Value<String> iconName;
  final Value<int> colorValue;
  final Value<int> xpReward;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.priority = const Value.absent(),
    this.iconName = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String category,
    required int difficulty,
    this.priority = const Value.absent(),
    required String iconName,
    required int colorValue,
    required int xpReward,
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       category = Value(category),
       difficulty = Value(difficulty),
       iconName = Value(iconName),
       colorValue = Value(colorValue),
       xpReward = Value(xpReward);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? difficulty,
    Expression<int>? priority,
    Expression<String>? iconName,
    Expression<int>? colorValue,
    Expression<int>? xpReward,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (difficulty != null) 'difficulty': difficulty,
      if (priority != null) 'priority': priority,
      if (iconName != null) 'icon_name': iconName,
      if (colorValue != null) 'color_value': colorValue,
      if (xpReward != null) 'xp_reward': xpReward,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? category,
    Value<int>? difficulty,
    Value<int>? priority,
    Value<String>? iconName,
    Value<int>? colorValue,
    Value<int>? xpReward,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      priority: priority ?? this.priority,
      iconName: iconName ?? this.iconName,
      colorValue: colorValue ?? this.colorValue,
      xpReward: xpReward ?? this.xpReward,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('priority: $priority, ')
          ..write('iconName: $iconName, ')
          ..write('colorValue: $colorValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HabitSchedulesTable extends HabitSchedules
    with TableInfo<$HabitSchedulesTable, HabitSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<String> weekdays = GeneratedColumn<String>(
    'weekdays',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reminderHourMeta = const VerificationMeta(
    'reminderHour',
  );
  @override
  late final GeneratedColumn<int> reminderHour = GeneratedColumn<int>(
    'reminder_hour',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderMinuteMeta = const VerificationMeta(
    'reminderMinute',
  );
  @override
  late final GeneratedColumn<int> reminderMinute = GeneratedColumn<int>(
    'reminder_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    weekdays,
    reminderEnabled,
    reminderHour,
    reminderMinute,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdaysMeta);
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_hour')) {
      context.handle(
        _reminderHourMeta,
        reminderHour.isAcceptableOrUnknown(
          data['reminder_hour']!,
          _reminderHourMeta,
        ),
      );
    }
    if (data.containsKey('reminder_minute')) {
      context.handle(
        _reminderMinuteMeta,
        reminderMinute.isAcceptableOrUnknown(
          data['reminder_minute']!,
          _reminderMinuteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays'],
      )!,
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      reminderHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_hour'],
      ),
      reminderMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minute'],
      ),
    );
  }

  @override
  $HabitSchedulesTable createAlias(String alias) {
    return $HabitSchedulesTable(attachedDatabase, alias);
  }
}

class HabitSchedule extends DataClass implements Insertable<HabitSchedule> {
  final int id;
  final int habitId;
  final String weekdays;
  final bool reminderEnabled;
  final int? reminderHour;
  final int? reminderMinute;
  const HabitSchedule({
    required this.id,
    required this.habitId,
    required this.weekdays,
    required this.reminderEnabled,
    this.reminderHour,
    this.reminderMinute,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['weekdays'] = Variable<String>(weekdays);
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    if (!nullToAbsent || reminderHour != null) {
      map['reminder_hour'] = Variable<int>(reminderHour);
    }
    if (!nullToAbsent || reminderMinute != null) {
      map['reminder_minute'] = Variable<int>(reminderMinute);
    }
    return map;
  }

  HabitSchedulesCompanion toCompanion(bool nullToAbsent) {
    return HabitSchedulesCompanion(
      id: Value(id),
      habitId: Value(habitId),
      weekdays: Value(weekdays),
      reminderEnabled: Value(reminderEnabled),
      reminderHour: reminderHour == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderHour),
      reminderMinute: reminderMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderMinute),
    );
  }

  factory HabitSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitSchedule(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      weekdays: serializer.fromJson<String>(json['weekdays']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      reminderHour: serializer.fromJson<int?>(json['reminderHour']),
      reminderMinute: serializer.fromJson<int?>(json['reminderMinute']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'weekdays': serializer.toJson<String>(weekdays),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'reminderHour': serializer.toJson<int?>(reminderHour),
      'reminderMinute': serializer.toJson<int?>(reminderMinute),
    };
  }

  HabitSchedule copyWith({
    int? id,
    int? habitId,
    String? weekdays,
    bool? reminderEnabled,
    Value<int?> reminderHour = const Value.absent(),
    Value<int?> reminderMinute = const Value.absent(),
  }) => HabitSchedule(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    weekdays: weekdays ?? this.weekdays,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    reminderHour: reminderHour.present ? reminderHour.value : this.reminderHour,
    reminderMinute: reminderMinute.present
        ? reminderMinute.value
        : this.reminderMinute,
  );
  HabitSchedule copyWithCompanion(HabitSchedulesCompanion data) {
    return HabitSchedule(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderHour: data.reminderHour.present
          ? data.reminderHour.value
          : this.reminderHour,
      reminderMinute: data.reminderMinute.present
          ? data.reminderMinute.value
          : this.reminderMinute,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitSchedule(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('weekdays: $weekdays, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderHour: $reminderHour, ')
          ..write('reminderMinute: $reminderMinute')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    weekdays,
    reminderEnabled,
    reminderHour,
    reminderMinute,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitSchedule &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.weekdays == this.weekdays &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderHour == this.reminderHour &&
          other.reminderMinute == this.reminderMinute);
}

class HabitSchedulesCompanion extends UpdateCompanion<HabitSchedule> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<String> weekdays;
  final Value<bool> reminderEnabled;
  final Value<int?> reminderHour;
  final Value<int?> reminderMinute;
  const HabitSchedulesCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderHour = const Value.absent(),
    this.reminderMinute = const Value.absent(),
  });
  HabitSchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required String weekdays,
    this.reminderEnabled = const Value.absent(),
    this.reminderHour = const Value.absent(),
    this.reminderMinute = const Value.absent(),
  }) : habitId = Value(habitId),
       weekdays = Value(weekdays);
  static Insertable<HabitSchedule> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<String>? weekdays,
    Expression<bool>? reminderEnabled,
    Expression<int>? reminderHour,
    Expression<int>? reminderMinute,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (weekdays != null) 'weekdays': weekdays,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderHour != null) 'reminder_hour': reminderHour,
      if (reminderMinute != null) 'reminder_minute': reminderMinute,
    });
  }

  HabitSchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<String>? weekdays,
    Value<bool>? reminderEnabled,
    Value<int?>? reminderHour,
    Value<int?>? reminderMinute,
  }) {
    return HabitSchedulesCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      weekdays: weekdays ?? this.weekdays,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<String>(weekdays.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (reminderHour.present) {
      map['reminder_hour'] = Variable<int>(reminderHour.value);
    }
    if (reminderMinute.present) {
      map['reminder_minute'] = Variable<int>(reminderMinute.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('weekdays: $weekdays, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderHour: $reminderHour, ')
          ..write('reminderMinute: $reminderMinute')
          ..write(')'))
        .toString();
  }
}

class $HabitCompletionsTable extends HabitCompletions
    with TableInfo<$HabitCompletionsTable, HabitCompletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _awardedXpMeta = const VerificationMeta(
    'awardedXp',
  );
  @override
  late final GeneratedColumn<int> awardedXp = GeneratedColumn<int>(
    'awarded_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _streakAfterCompletionMeta =
      const VerificationMeta('streakAfterCompletion');
  @override
  late final GeneratedColumn<int> streakAfterCompletion = GeneratedColumn<int>(
    'streak_after_completion',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    dayKey,
    completedAt,
    awardedXp,
    streakAfterCompletion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitCompletion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('awarded_xp')) {
      context.handle(
        _awardedXpMeta,
        awardedXp.isAcceptableOrUnknown(data['awarded_xp']!, _awardedXpMeta),
      );
    } else if (isInserting) {
      context.missing(_awardedXpMeta);
    }
    if (data.containsKey('streak_after_completion')) {
      context.handle(
        _streakAfterCompletionMeta,
        streakAfterCompletion.isAcceptableOrUnknown(
          data['streak_after_completion']!,
          _streakAfterCompletionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitCompletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCompletion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      awardedXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}awarded_xp'],
      )!,
      streakAfterCompletion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_after_completion'],
      )!,
    );
  }

  @override
  $HabitCompletionsTable createAlias(String alias) {
    return $HabitCompletionsTable(attachedDatabase, alias);
  }
}

class HabitCompletion extends DataClass implements Insertable<HabitCompletion> {
  final int id;
  final int habitId;
  final String dayKey;
  final DateTime completedAt;
  final int awardedXp;
  final int streakAfterCompletion;
  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.dayKey,
    required this.completedAt,
    required this.awardedXp,
    required this.streakAfterCompletion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['day_key'] = Variable<String>(dayKey);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['awarded_xp'] = Variable<int>(awardedXp);
    map['streak_after_completion'] = Variable<int>(streakAfterCompletion);
    return map;
  }

  HabitCompletionsCompanion toCompanion(bool nullToAbsent) {
    return HabitCompletionsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      dayKey: Value(dayKey),
      completedAt: Value(completedAt),
      awardedXp: Value(awardedXp),
      streakAfterCompletion: Value(streakAfterCompletion),
    );
  }

  factory HabitCompletion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCompletion(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      dayKey: serializer.fromJson<String>(json['dayKey']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      awardedXp: serializer.fromJson<int>(json['awardedXp']),
      streakAfterCompletion: serializer.fromJson<int>(
        json['streakAfterCompletion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'dayKey': serializer.toJson<String>(dayKey),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'awardedXp': serializer.toJson<int>(awardedXp),
      'streakAfterCompletion': serializer.toJson<int>(streakAfterCompletion),
    };
  }

  HabitCompletion copyWith({
    int? id,
    int? habitId,
    String? dayKey,
    DateTime? completedAt,
    int? awardedXp,
    int? streakAfterCompletion,
  }) => HabitCompletion(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    dayKey: dayKey ?? this.dayKey,
    completedAt: completedAt ?? this.completedAt,
    awardedXp: awardedXp ?? this.awardedXp,
    streakAfterCompletion: streakAfterCompletion ?? this.streakAfterCompletion,
  );
  HabitCompletion copyWithCompanion(HabitCompletionsCompanion data) {
    return HabitCompletion(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      awardedXp: data.awardedXp.present ? data.awardedXp.value : this.awardedXp,
      streakAfterCompletion: data.streakAfterCompletion.present
          ? data.streakAfterCompletion.value
          : this.streakAfterCompletion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('dayKey: $dayKey, ')
          ..write('completedAt: $completedAt, ')
          ..write('awardedXp: $awardedXp, ')
          ..write('streakAfterCompletion: $streakAfterCompletion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    dayKey,
    completedAt,
    awardedXp,
    streakAfterCompletion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitCompletion &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.dayKey == this.dayKey &&
          other.completedAt == this.completedAt &&
          other.awardedXp == this.awardedXp &&
          other.streakAfterCompletion == this.streakAfterCompletion);
}

class HabitCompletionsCompanion extends UpdateCompanion<HabitCompletion> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<String> dayKey;
  final Value<DateTime> completedAt;
  final Value<int> awardedXp;
  final Value<int> streakAfterCompletion;
  const HabitCompletionsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.dayKey = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.awardedXp = const Value.absent(),
    this.streakAfterCompletion = const Value.absent(),
  });
  HabitCompletionsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required String dayKey,
    required DateTime completedAt,
    required int awardedXp,
    this.streakAfterCompletion = const Value.absent(),
  }) : habitId = Value(habitId),
       dayKey = Value(dayKey),
       completedAt = Value(completedAt),
       awardedXp = Value(awardedXp);
  static Insertable<HabitCompletion> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<String>? dayKey,
    Expression<DateTime>? completedAt,
    Expression<int>? awardedXp,
    Expression<int>? streakAfterCompletion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (dayKey != null) 'day_key': dayKey,
      if (completedAt != null) 'completed_at': completedAt,
      if (awardedXp != null) 'awarded_xp': awardedXp,
      if (streakAfterCompletion != null)
        'streak_after_completion': streakAfterCompletion,
    });
  }

  HabitCompletionsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<String>? dayKey,
    Value<DateTime>? completedAt,
    Value<int>? awardedXp,
    Value<int>? streakAfterCompletion,
  }) {
    return HabitCompletionsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      dayKey: dayKey ?? this.dayKey,
      completedAt: completedAt ?? this.completedAt,
      awardedXp: awardedXp ?? this.awardedXp,
      streakAfterCompletion:
          streakAfterCompletion ?? this.streakAfterCompletion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (awardedXp.present) {
      map['awarded_xp'] = Variable<int>(awardedXp.value);
    }
    if (streakAfterCompletion.present) {
      map['streak_after_completion'] = Variable<int>(
        streakAfterCompletion.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletionsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('dayKey: $dayKey, ')
          ..write('completedAt: $completedAt, ')
          ..write('awardedXp: $awardedXp, ')
          ..write('streakAfterCompletion: $streakAfterCompletion')
          ..write(')'))
        .toString();
  }
}

class $AchievementEntriesTable extends AchievementEntries
    with TableInfo<$AchievementEntriesTable, AchievementEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, progress, unlockedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievement_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AchievementEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
    );
  }

  @override
  $AchievementEntriesTable createAlias(String alias) {
    return $AchievementEntriesTable(attachedDatabase, alias);
  }
}

class AchievementEntry extends DataClass
    implements Insertable<AchievementEntry> {
  final String key;
  final int progress;
  final DateTime? unlockedAt;
  const AchievementEntry({
    required this.key,
    required this.progress,
    this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['progress'] = Variable<int>(progress);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    return map;
  }

  AchievementEntriesCompanion toCompanion(bool nullToAbsent) {
    return AchievementEntriesCompanion(
      key: Value(key),
      progress: Value(progress),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory AchievementEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementEntry(
      key: serializer.fromJson<String>(json['key']),
      progress: serializer.fromJson<int>(json['progress']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'progress': serializer.toJson<int>(progress),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
    };
  }

  AchievementEntry copyWith({
    String? key,
    int? progress,
    Value<DateTime?> unlockedAt = const Value.absent(),
  }) => AchievementEntry(
    key: key ?? this.key,
    progress: progress ?? this.progress,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
  );
  AchievementEntry copyWithCompanion(AchievementEntriesCompanion data) {
    return AchievementEntry(
      key: data.key.present ? data.key.value : this.key,
      progress: data.progress.present ? data.progress.value : this.progress,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementEntry(')
          ..write('key: $key, ')
          ..write('progress: $progress, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, progress, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementEntry &&
          other.key == this.key &&
          other.progress == this.progress &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementEntriesCompanion extends UpdateCompanion<AchievementEntry> {
  final Value<String> key;
  final Value<int> progress;
  final Value<DateTime?> unlockedAt;
  final Value<int> rowid;
  const AchievementEntriesCompanion({
    this.key = const Value.absent(),
    this.progress = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementEntriesCompanion.insert({
    required String key,
    this.progress = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<AchievementEntry> custom({
    Expression<String>? key,
    Expression<int>? progress,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (progress != null) 'progress': progress,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementEntriesCompanion copyWith({
    Value<String>? key,
    Value<int>? progress,
    Value<DateTime?>? unlockedAt,
    Value<int>? rowid,
  }) {
    return AchievementEntriesCompanion(
      key: key ?? this.key,
      progress: progress ?? this.progress,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementEntriesCompanion(')
          ..write('key: $key, ')
          ..write('progress: $progress, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyCheckInsTable extends DailyCheckIns
    with TableInfo<$DailyCheckInsTable, DailyCheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyMeta = const VerificationMeta('energy');
  @override
  late final GeneratedColumn<int> energy = GeneratedColumn<int>(
    'energy',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loadMeta = const VerificationMeta('load');
  @override
  late final GeneratedColumn<int> load = GeneratedColumn<int>(
    'load',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [dayKey, energy, load, mood, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCheckIn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('energy')) {
      context.handle(
        _energyMeta,
        energy.isAcceptableOrUnknown(data['energy']!, _energyMeta),
      );
    } else if (isInserting) {
      context.missing(_energyMeta);
    }
    if (data.containsKey('load')) {
      context.handle(
        _loadMeta,
        load.isAcceptableOrUnknown(data['load']!, _loadMeta),
      );
    } else if (isInserting) {
      context.missing(_loadMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    } else if (isInserting) {
      context.missing(_moodMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dayKey};
  @override
  DailyCheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCheckIn(
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      energy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy'],
      )!,
      load: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}load'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DailyCheckInsTable createAlias(String alias) {
    return $DailyCheckInsTable(attachedDatabase, alias);
  }
}

class DailyCheckIn extends DataClass implements Insertable<DailyCheckIn> {
  final String dayKey;
  final int energy;
  final int load;
  final int mood;
  final DateTime createdAt;
  const DailyCheckIn({
    required this.dayKey,
    required this.energy,
    required this.load,
    required this.mood,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day_key'] = Variable<String>(dayKey);
    map['energy'] = Variable<int>(energy);
    map['load'] = Variable<int>(load);
    map['mood'] = Variable<int>(mood);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailyCheckInsCompanion toCompanion(bool nullToAbsent) {
    return DailyCheckInsCompanion(
      dayKey: Value(dayKey),
      energy: Value(energy),
      load: Value(load),
      mood: Value(mood),
      createdAt: Value(createdAt),
    );
  }

  factory DailyCheckIn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCheckIn(
      dayKey: serializer.fromJson<String>(json['dayKey']),
      energy: serializer.fromJson<int>(json['energy']),
      load: serializer.fromJson<int>(json['load']),
      mood: serializer.fromJson<int>(json['mood']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dayKey': serializer.toJson<String>(dayKey),
      'energy': serializer.toJson<int>(energy),
      'load': serializer.toJson<int>(load),
      'mood': serializer.toJson<int>(mood),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailyCheckIn copyWith({
    String? dayKey,
    int? energy,
    int? load,
    int? mood,
    DateTime? createdAt,
  }) => DailyCheckIn(
    dayKey: dayKey ?? this.dayKey,
    energy: energy ?? this.energy,
    load: load ?? this.load,
    mood: mood ?? this.mood,
    createdAt: createdAt ?? this.createdAt,
  );
  DailyCheckIn copyWithCompanion(DailyCheckInsCompanion data) {
    return DailyCheckIn(
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      energy: data.energy.present ? data.energy.value : this.energy,
      load: data.load.present ? data.load.value : this.load,
      mood: data.mood.present ? data.mood.value : this.mood,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckIn(')
          ..write('dayKey: $dayKey, ')
          ..write('energy: $energy, ')
          ..write('load: $load, ')
          ..write('mood: $mood, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dayKey, energy, load, mood, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCheckIn &&
          other.dayKey == this.dayKey &&
          other.energy == this.energy &&
          other.load == this.load &&
          other.mood == this.mood &&
          other.createdAt == this.createdAt);
}

class DailyCheckInsCompanion extends UpdateCompanion<DailyCheckIn> {
  final Value<String> dayKey;
  final Value<int> energy;
  final Value<int> load;
  final Value<int> mood;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DailyCheckInsCompanion({
    this.dayKey = const Value.absent(),
    this.energy = const Value.absent(),
    this.load = const Value.absent(),
    this.mood = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyCheckInsCompanion.insert({
    required String dayKey,
    required int energy,
    required int load,
    required int mood,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : dayKey = Value(dayKey),
       energy = Value(energy),
       load = Value(load),
       mood = Value(mood),
       createdAt = Value(createdAt);
  static Insertable<DailyCheckIn> custom({
    Expression<String>? dayKey,
    Expression<int>? energy,
    Expression<int>? load,
    Expression<int>? mood,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dayKey != null) 'day_key': dayKey,
      if (energy != null) 'energy': energy,
      if (load != null) 'load': load,
      if (mood != null) 'mood': mood,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyCheckInsCompanion copyWith({
    Value<String>? dayKey,
    Value<int>? energy,
    Value<int>? load,
    Value<int>? mood,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DailyCheckInsCompanion(
      dayKey: dayKey ?? this.dayKey,
      energy: energy ?? this.energy,
      load: load ?? this.load,
      mood: mood ?? this.mood,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (energy.present) {
      map['energy'] = Variable<int>(energy.value);
    }
    if (load.present) {
      map['load'] = Variable<int>(load.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckInsCompanion(')
          ..write('dayKey: $dayKey, ')
          ..write('energy: $energy, ')
          ..write('load: $load, ')
          ..write('mood: $mood, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecoveryDayEntriesTable extends RecoveryDayEntries
    with TableInfo<$RecoveryDayEntriesTable, RecoveryDayEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecoveryDayEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskScoreMeta = const VerificationMeta(
    'riskScore',
  );
  @override
  late final GeneratedColumn<int> riskScore = GeneratedColumn<int>(
    'risk_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reasonsMeta = const VerificationMeta(
    'reasons',
  );
  @override
  late final GeneratedColumn<String> reasons = GeneratedColumn<String>(
    'reasons',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _suggestedHabitIdsMeta = const VerificationMeta(
    'suggestedHabitIds',
  );
  @override
  late final GeneratedColumn<String> suggestedHabitIds =
      GeneratedColumn<String>(
        'suggested_habit_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _lightPlanAcceptedMeta = const VerificationMeta(
    'lightPlanAccepted',
  );
  @override
  late final GeneratedColumn<bool> lightPlanAccepted = GeneratedColumn<bool>(
    'light_plan_accepted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("light_plan_accepted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lightPlanAcceptedAtMeta =
      const VerificationMeta('lightPlanAcceptedAt');
  @override
  late final GeneratedColumn<DateTime> lightPlanAcceptedAt =
      GeneratedColumn<DateTime>(
        'light_plan_accepted_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    dayKey,
    status,
    riskScore,
    reasons,
    suggestedHabitIds,
    lightPlanAccepted,
    lightPlanAcceptedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recovery_day_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecoveryDayEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('risk_score')) {
      context.handle(
        _riskScoreMeta,
        riskScore.isAcceptableOrUnknown(data['risk_score']!, _riskScoreMeta),
      );
    }
    if (data.containsKey('reasons')) {
      context.handle(
        _reasonsMeta,
        reasons.isAcceptableOrUnknown(data['reasons']!, _reasonsMeta),
      );
    }
    if (data.containsKey('suggested_habit_ids')) {
      context.handle(
        _suggestedHabitIdsMeta,
        suggestedHabitIds.isAcceptableOrUnknown(
          data['suggested_habit_ids']!,
          _suggestedHabitIdsMeta,
        ),
      );
    }
    if (data.containsKey('light_plan_accepted')) {
      context.handle(
        _lightPlanAcceptedMeta,
        lightPlanAccepted.isAcceptableOrUnknown(
          data['light_plan_accepted']!,
          _lightPlanAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('light_plan_accepted_at')) {
      context.handle(
        _lightPlanAcceptedAtMeta,
        lightPlanAcceptedAt.isAcceptableOrUnknown(
          data['light_plan_accepted_at']!,
          _lightPlanAcceptedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dayKey};
  @override
  RecoveryDayEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoveryDayEntry(
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      riskScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}risk_score'],
      )!,
      reasons: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reasons'],
      )!,
      suggestedHabitIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggested_habit_ids'],
      )!,
      lightPlanAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}light_plan_accepted'],
      )!,
      lightPlanAcceptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}light_plan_accepted_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecoveryDayEntriesTable createAlias(String alias) {
    return $RecoveryDayEntriesTable(attachedDatabase, alias);
  }
}

class RecoveryDayEntry extends DataClass
    implements Insertable<RecoveryDayEntry> {
  final String dayKey;
  final String status;
  final int riskScore;
  final String reasons;
  final String suggestedHabitIds;
  final bool lightPlanAccepted;
  final DateTime? lightPlanAcceptedAt;
  final DateTime createdAt;
  const RecoveryDayEntry({
    required this.dayKey,
    required this.status,
    required this.riskScore,
    required this.reasons,
    required this.suggestedHabitIds,
    required this.lightPlanAccepted,
    this.lightPlanAcceptedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day_key'] = Variable<String>(dayKey);
    map['status'] = Variable<String>(status);
    map['risk_score'] = Variable<int>(riskScore);
    map['reasons'] = Variable<String>(reasons);
    map['suggested_habit_ids'] = Variable<String>(suggestedHabitIds);
    map['light_plan_accepted'] = Variable<bool>(lightPlanAccepted);
    if (!nullToAbsent || lightPlanAcceptedAt != null) {
      map['light_plan_accepted_at'] = Variable<DateTime>(lightPlanAcceptedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecoveryDayEntriesCompanion toCompanion(bool nullToAbsent) {
    return RecoveryDayEntriesCompanion(
      dayKey: Value(dayKey),
      status: Value(status),
      riskScore: Value(riskScore),
      reasons: Value(reasons),
      suggestedHabitIds: Value(suggestedHabitIds),
      lightPlanAccepted: Value(lightPlanAccepted),
      lightPlanAcceptedAt: lightPlanAcceptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lightPlanAcceptedAt),
      createdAt: Value(createdAt),
    );
  }

  factory RecoveryDayEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoveryDayEntry(
      dayKey: serializer.fromJson<String>(json['dayKey']),
      status: serializer.fromJson<String>(json['status']),
      riskScore: serializer.fromJson<int>(json['riskScore']),
      reasons: serializer.fromJson<String>(json['reasons']),
      suggestedHabitIds: serializer.fromJson<String>(json['suggestedHabitIds']),
      lightPlanAccepted: serializer.fromJson<bool>(json['lightPlanAccepted']),
      lightPlanAcceptedAt: serializer.fromJson<DateTime?>(
        json['lightPlanAcceptedAt'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dayKey': serializer.toJson<String>(dayKey),
      'status': serializer.toJson<String>(status),
      'riskScore': serializer.toJson<int>(riskScore),
      'reasons': serializer.toJson<String>(reasons),
      'suggestedHabitIds': serializer.toJson<String>(suggestedHabitIds),
      'lightPlanAccepted': serializer.toJson<bool>(lightPlanAccepted),
      'lightPlanAcceptedAt': serializer.toJson<DateTime?>(lightPlanAcceptedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecoveryDayEntry copyWith({
    String? dayKey,
    String? status,
    int? riskScore,
    String? reasons,
    String? suggestedHabitIds,
    bool? lightPlanAccepted,
    Value<DateTime?> lightPlanAcceptedAt = const Value.absent(),
    DateTime? createdAt,
  }) => RecoveryDayEntry(
    dayKey: dayKey ?? this.dayKey,
    status: status ?? this.status,
    riskScore: riskScore ?? this.riskScore,
    reasons: reasons ?? this.reasons,
    suggestedHabitIds: suggestedHabitIds ?? this.suggestedHabitIds,
    lightPlanAccepted: lightPlanAccepted ?? this.lightPlanAccepted,
    lightPlanAcceptedAt: lightPlanAcceptedAt.present
        ? lightPlanAcceptedAt.value
        : this.lightPlanAcceptedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  RecoveryDayEntry copyWithCompanion(RecoveryDayEntriesCompanion data) {
    return RecoveryDayEntry(
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      status: data.status.present ? data.status.value : this.status,
      riskScore: data.riskScore.present ? data.riskScore.value : this.riskScore,
      reasons: data.reasons.present ? data.reasons.value : this.reasons,
      suggestedHabitIds: data.suggestedHabitIds.present
          ? data.suggestedHabitIds.value
          : this.suggestedHabitIds,
      lightPlanAccepted: data.lightPlanAccepted.present
          ? data.lightPlanAccepted.value
          : this.lightPlanAccepted,
      lightPlanAcceptedAt: data.lightPlanAcceptedAt.present
          ? data.lightPlanAcceptedAt.value
          : this.lightPlanAcceptedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryDayEntry(')
          ..write('dayKey: $dayKey, ')
          ..write('status: $status, ')
          ..write('riskScore: $riskScore, ')
          ..write('reasons: $reasons, ')
          ..write('suggestedHabitIds: $suggestedHabitIds, ')
          ..write('lightPlanAccepted: $lightPlanAccepted, ')
          ..write('lightPlanAcceptedAt: $lightPlanAcceptedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    dayKey,
    status,
    riskScore,
    reasons,
    suggestedHabitIds,
    lightPlanAccepted,
    lightPlanAcceptedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoveryDayEntry &&
          other.dayKey == this.dayKey &&
          other.status == this.status &&
          other.riskScore == this.riskScore &&
          other.reasons == this.reasons &&
          other.suggestedHabitIds == this.suggestedHabitIds &&
          other.lightPlanAccepted == this.lightPlanAccepted &&
          other.lightPlanAcceptedAt == this.lightPlanAcceptedAt &&
          other.createdAt == this.createdAt);
}

class RecoveryDayEntriesCompanion extends UpdateCompanion<RecoveryDayEntry> {
  final Value<String> dayKey;
  final Value<String> status;
  final Value<int> riskScore;
  final Value<String> reasons;
  final Value<String> suggestedHabitIds;
  final Value<bool> lightPlanAccepted;
  final Value<DateTime?> lightPlanAcceptedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecoveryDayEntriesCompanion({
    this.dayKey = const Value.absent(),
    this.status = const Value.absent(),
    this.riskScore = const Value.absent(),
    this.reasons = const Value.absent(),
    this.suggestedHabitIds = const Value.absent(),
    this.lightPlanAccepted = const Value.absent(),
    this.lightPlanAcceptedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoveryDayEntriesCompanion.insert({
    required String dayKey,
    required String status,
    this.riskScore = const Value.absent(),
    this.reasons = const Value.absent(),
    this.suggestedHabitIds = const Value.absent(),
    this.lightPlanAccepted = const Value.absent(),
    this.lightPlanAcceptedAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : dayKey = Value(dayKey),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<RecoveryDayEntry> custom({
    Expression<String>? dayKey,
    Expression<String>? status,
    Expression<int>? riskScore,
    Expression<String>? reasons,
    Expression<String>? suggestedHabitIds,
    Expression<bool>? lightPlanAccepted,
    Expression<DateTime>? lightPlanAcceptedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dayKey != null) 'day_key': dayKey,
      if (status != null) 'status': status,
      if (riskScore != null) 'risk_score': riskScore,
      if (reasons != null) 'reasons': reasons,
      if (suggestedHabitIds != null) 'suggested_habit_ids': suggestedHabitIds,
      if (lightPlanAccepted != null) 'light_plan_accepted': lightPlanAccepted,
      if (lightPlanAcceptedAt != null)
        'light_plan_accepted_at': lightPlanAcceptedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoveryDayEntriesCompanion copyWith({
    Value<String>? dayKey,
    Value<String>? status,
    Value<int>? riskScore,
    Value<String>? reasons,
    Value<String>? suggestedHabitIds,
    Value<bool>? lightPlanAccepted,
    Value<DateTime?>? lightPlanAcceptedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RecoveryDayEntriesCompanion(
      dayKey: dayKey ?? this.dayKey,
      status: status ?? this.status,
      riskScore: riskScore ?? this.riskScore,
      reasons: reasons ?? this.reasons,
      suggestedHabitIds: suggestedHabitIds ?? this.suggestedHabitIds,
      lightPlanAccepted: lightPlanAccepted ?? this.lightPlanAccepted,
      lightPlanAcceptedAt: lightPlanAcceptedAt ?? this.lightPlanAcceptedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (riskScore.present) {
      map['risk_score'] = Variable<int>(riskScore.value);
    }
    if (reasons.present) {
      map['reasons'] = Variable<String>(reasons.value);
    }
    if (suggestedHabitIds.present) {
      map['suggested_habit_ids'] = Variable<String>(suggestedHabitIds.value);
    }
    if (lightPlanAccepted.present) {
      map['light_plan_accepted'] = Variable<bool>(lightPlanAccepted.value);
    }
    if (lightPlanAcceptedAt.present) {
      map['light_plan_accepted_at'] = Variable<DateTime>(
        lightPlanAcceptedAt.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryDayEntriesCompanion(')
          ..write('dayKey: $dayKey, ')
          ..write('status: $status, ')
          ..write('riskScore: $riskScore, ')
          ..write('reasons: $reasons, ')
          ..write('suggestedHabitIds: $suggestedHabitIds, ')
          ..write('lightPlanAccepted: $lightPlanAccepted, ')
          ..write('lightPlanAcceptedAt: $lightPlanAcceptedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $UserProgressEntriesTable userProgressEntries =
      $UserProgressEntriesTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitSchedulesTable habitSchedules = $HabitSchedulesTable(this);
  late final $HabitCompletionsTable habitCompletions = $HabitCompletionsTable(
    this,
  );
  late final $AchievementEntriesTable achievementEntries =
      $AchievementEntriesTable(this);
  late final $DailyCheckInsTable dailyCheckIns = $DailyCheckInsTable(this);
  late final $RecoveryDayEntriesTable recoveryDayEntries =
      $RecoveryDayEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    userProgressEntries,
    habits,
    habitSchedules,
    habitCompletions,
    achievementEntries,
    dailyCheckIns,
    recoveryDayEntries,
  ];
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<String?> goal,
      Value<String?> routine,
      Value<bool> onboardingCompleted,
      Value<bool> notificationsEnabled,
      Value<String?> timeZone,
      Value<DateTime?> createdAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<String?> goal,
      Value<String?> routine,
      Value<bool> onboardingCompleted,
      Value<bool> notificationsEnabled,
      Value<String?> timeZone,
      Value<DateTime?> createdAt,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routine => $composableBuilder(
    column: $table.routine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routine => $composableBuilder(
    column: $table.routine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get routine =>
      $composableBuilder(column: $table.routine, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeZone =>
      $composableBuilder(column: $table.timeZone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String?> routine = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<String?> timeZone = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                name: name,
                goal: goal,
                routine: routine,
                onboardingCompleted: onboardingCompleted,
                notificationsEnabled: notificationsEnabled,
                timeZone: timeZone,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String?> routine = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<String?> timeZone = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                name: name,
                goal: goal,
                routine: routine,
                onboardingCompleted: onboardingCompleted,
                notificationsEnabled: notificationsEnabled,
                timeZone: timeZone,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$UserProgressEntriesTableCreateCompanionBuilder =
    UserProgressEntriesCompanion Function({
      Value<int> id,
      Value<int> totalXp,
      Value<int> level,
      Value<int> currentStreak,
      Value<int> bestStreak,
      Value<int> completedToday,
      Value<int> totalCompletions,
    });
typedef $$UserProgressEntriesTableUpdateCompanionBuilder =
    UserProgressEntriesCompanion Function({
      Value<int> id,
      Value<int> totalXp,
      Value<int> level,
      Value<int> currentStreak,
      Value<int> bestStreak,
      Value<int> completedToday,
      Value<int> totalCompletions,
    });

class $$UserProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProgressEntriesTable> {
  $$UserProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedToday => $composableBuilder(
    column: $table.completedToday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCompletions => $composableBuilder(
    column: $table.totalCompletions,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProgressEntriesTable> {
  $$UserProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedToday => $composableBuilder(
    column: $table.completedToday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCompletions => $composableBuilder(
    column: $table.totalCompletions,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProgressEntriesTable> {
  $$UserProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedToday => $composableBuilder(
    column: $table.completedToday,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCompletions => $composableBuilder(
    column: $table.totalCompletions,
    builder: (column) => column,
  );
}

class $$UserProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProgressEntriesTable,
          UserProgressEntry,
          $$UserProgressEntriesTableFilterComposer,
          $$UserProgressEntriesTableOrderingComposer,
          $$UserProgressEntriesTableAnnotationComposer,
          $$UserProgressEntriesTableCreateCompanionBuilder,
          $$UserProgressEntriesTableUpdateCompanionBuilder,
          (
            UserProgressEntry,
            BaseReferences<
              _$AppDatabase,
              $UserProgressEntriesTable,
              UserProgressEntry
            >,
          ),
          UserProgressEntry,
          PrefetchHooks Function()
        > {
  $$UserProgressEntriesTableTableManager(
    _$AppDatabase db,
    $UserProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProgressEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserProgressEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<int> completedToday = const Value.absent(),
                Value<int> totalCompletions = const Value.absent(),
              }) => UserProgressEntriesCompanion(
                id: id,
                totalXp: totalXp,
                level: level,
                currentStreak: currentStreak,
                bestStreak: bestStreak,
                completedToday: completedToday,
                totalCompletions: totalCompletions,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<int> completedToday = const Value.absent(),
                Value<int> totalCompletions = const Value.absent(),
              }) => UserProgressEntriesCompanion.insert(
                id: id,
                totalXp: totalXp,
                level: level,
                currentStreak: currentStreak,
                bestStreak: bestStreak,
                completedToday: completedToday,
                totalCompletions: totalCompletions,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProgressEntriesTable,
      UserProgressEntry,
      $$UserProgressEntriesTableFilterComposer,
      $$UserProgressEntriesTableOrderingComposer,
      $$UserProgressEntriesTableAnnotationComposer,
      $$UserProgressEntriesTableCreateCompanionBuilder,
      $$UserProgressEntriesTableUpdateCompanionBuilder,
      (
        UserProgressEntry,
        BaseReferences<
          _$AppDatabase,
          $UserProgressEntriesTable,
          UserProgressEntry
        >,
      ),
      UserProgressEntry,
      PrefetchHooks Function()
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String title,
      Value<String> description,
      required String category,
      required int difficulty,
      Value<int> priority,
      required String iconName,
      required int colorValue,
      required int xpReward,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<String> category,
      Value<int> difficulty,
      Value<int> priority,
      Value<String> iconName,
      Value<int> colorValue,
      Value<int> xpReward,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitSchedulesTable, List<HabitSchedule>>
  _habitSchedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitSchedules,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitSchedules.habitId),
  );

  $$HabitSchedulesTableProcessedTableManager get habitSchedulesRefs {
    final manager = $$HabitSchedulesTableTableManager(
      $_db,
      $_db.habitSchedules,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitSchedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HabitCompletionsTable, List<HabitCompletion>>
  _habitCompletionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitCompletions,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitCompletions.habitId),
  );

  $$HabitCompletionsTableProcessedTableManager get habitCompletionsRefs {
    final manager = $$HabitCompletionsTableTableManager(
      $_db,
      $_db.habitCompletions,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _habitCompletionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitSchedulesRefs(
    Expression<bool> Function($$HabitSchedulesTableFilterComposer f) f,
  ) {
    final $$HabitSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitSchedules,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.habitSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> habitCompletionsRefs(
    Expression<bool> Function($$HabitCompletionsTableFilterComposer f) f,
  ) {
    final $$HabitCompletionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableFilterComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> habitSchedulesRefs<T extends Object>(
    Expression<T> Function($$HabitSchedulesTableAnnotationComposer a) f,
  ) {
    final $$HabitSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitSchedules,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.habitSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> habitCompletionsRefs<T extends Object>(
    Expression<T> Function($$HabitCompletionsTableAnnotationComposer a) f,
  ) {
    final $$HabitCompletionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, $$HabitsTableReferences),
          Habit,
          PrefetchHooks Function({
            bool habitSchedulesRefs,
            bool habitCompletionsRefs,
          })
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                title: title,
                description: description,
                category: category,
                difficulty: difficulty,
                priority: priority,
                iconName: iconName,
                colorValue: colorValue,
                xpReward: xpReward,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String> description = const Value.absent(),
                required String category,
                required int difficulty,
                Value<int> priority = const Value.absent(),
                required String iconName,
                required int colorValue,
                required int xpReward,
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                title: title,
                description: description,
                category: category,
                difficulty: difficulty,
                priority: priority,
                iconName: iconName,
                colorValue: colorValue,
                xpReward: xpReward,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({habitSchedulesRefs = false, habitCompletionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitSchedulesRefs) db.habitSchedules,
                    if (habitCompletionsRefs) db.habitCompletions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (habitSchedulesRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          HabitSchedule
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._habitSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitSchedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (habitCompletionsRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          HabitCompletion
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._habitCompletionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitCompletionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, $$HabitsTableReferences),
      Habit,
      PrefetchHooks Function({
        bool habitSchedulesRefs,
        bool habitCompletionsRefs,
      })
    >;
typedef $$HabitSchedulesTableCreateCompanionBuilder =
    HabitSchedulesCompanion Function({
      Value<int> id,
      required int habitId,
      required String weekdays,
      Value<bool> reminderEnabled,
      Value<int?> reminderHour,
      Value<int?> reminderMinute,
    });
typedef $$HabitSchedulesTableUpdateCompanionBuilder =
    HabitSchedulesCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<String> weekdays,
      Value<bool> reminderEnabled,
      Value<int?> reminderHour,
      Value<int?> reminderMinute,
    });

final class $$HabitSchedulesTableReferences
    extends BaseReferences<_$AppDatabase, $HabitSchedulesTable, HabitSchedule> {
  $$HabitSchedulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitSchedules.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $HabitSchedulesTable> {
  $$HabitSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderHour => $composableBuilder(
    column: $table.reminderHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitSchedulesTable> {
  $$HabitSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderHour => $composableBuilder(
    column: $table.reminderHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitSchedulesTable> {
  $$HabitSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderHour => $composableBuilder(
    column: $table.reminderHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => column,
  );

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitSchedulesTable,
          HabitSchedule,
          $$HabitSchedulesTableFilterComposer,
          $$HabitSchedulesTableOrderingComposer,
          $$HabitSchedulesTableAnnotationComposer,
          $$HabitSchedulesTableCreateCompanionBuilder,
          $$HabitSchedulesTableUpdateCompanionBuilder,
          (HabitSchedule, $$HabitSchedulesTableReferences),
          HabitSchedule,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitSchedulesTableTableManager(
    _$AppDatabase db,
    $HabitSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<String> weekdays = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int?> reminderHour = const Value.absent(),
                Value<int?> reminderMinute = const Value.absent(),
              }) => HabitSchedulesCompanion(
                id: id,
                habitId: habitId,
                weekdays: weekdays,
                reminderEnabled: reminderEnabled,
                reminderHour: reminderHour,
                reminderMinute: reminderMinute,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required String weekdays,
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int?> reminderHour = const Value.absent(),
                Value<int?> reminderMinute = const Value.absent(),
              }) => HabitSchedulesCompanion.insert(
                id: id,
                habitId: habitId,
                weekdays: weekdays,
                reminderEnabled: reminderEnabled,
                reminderHour: reminderHour,
                reminderMinute: reminderMinute,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitSchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$HabitSchedulesTableReferences
                                    ._habitIdTable(db),
                                referencedColumn:
                                    $$HabitSchedulesTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitSchedulesTable,
      HabitSchedule,
      $$HabitSchedulesTableFilterComposer,
      $$HabitSchedulesTableOrderingComposer,
      $$HabitSchedulesTableAnnotationComposer,
      $$HabitSchedulesTableCreateCompanionBuilder,
      $$HabitSchedulesTableUpdateCompanionBuilder,
      (HabitSchedule, $$HabitSchedulesTableReferences),
      HabitSchedule,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$HabitCompletionsTableCreateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<int> id,
      required int habitId,
      required String dayKey,
      required DateTime completedAt,
      required int awardedXp,
      Value<int> streakAfterCompletion,
    });
typedef $$HabitCompletionsTableUpdateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<String> dayKey,
      Value<DateTime> completedAt,
      Value<int> awardedXp,
      Value<int> streakAfterCompletion,
    });

final class $$HabitCompletionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HabitCompletionsTable, HabitCompletion> {
  $$HabitCompletionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitCompletions.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awardedXp => $composableBuilder(
    column: $table.awardedXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakAfterCompletion => $composableBuilder(
    column: $table.streakAfterCompletion,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awardedXp => $composableBuilder(
    column: $table.awardedXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakAfterCompletion => $composableBuilder(
    column: $table.streakAfterCompletion,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get awardedXp =>
      $composableBuilder(column: $table.awardedXp, builder: (column) => column);

  GeneratedColumn<int> get streakAfterCompletion => $composableBuilder(
    column: $table.streakAfterCompletion,
    builder: (column) => column,
  );

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitCompletionsTable,
          HabitCompletion,
          $$HabitCompletionsTableFilterComposer,
          $$HabitCompletionsTableOrderingComposer,
          $$HabitCompletionsTableAnnotationComposer,
          $$HabitCompletionsTableCreateCompanionBuilder,
          $$HabitCompletionsTableUpdateCompanionBuilder,
          (HabitCompletion, $$HabitCompletionsTableReferences),
          HabitCompletion,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitCompletionsTableTableManager(
    _$AppDatabase db,
    $HabitCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<String> dayKey = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> awardedXp = const Value.absent(),
                Value<int> streakAfterCompletion = const Value.absent(),
              }) => HabitCompletionsCompanion(
                id: id,
                habitId: habitId,
                dayKey: dayKey,
                completedAt: completedAt,
                awardedXp: awardedXp,
                streakAfterCompletion: streakAfterCompletion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required String dayKey,
                required DateTime completedAt,
                required int awardedXp,
                Value<int> streakAfterCompletion = const Value.absent(),
              }) => HabitCompletionsCompanion.insert(
                id: id,
                habitId: habitId,
                dayKey: dayKey,
                completedAt: completedAt,
                awardedXp: awardedXp,
                streakAfterCompletion: streakAfterCompletion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitCompletionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$HabitCompletionsTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$HabitCompletionsTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitCompletionsTable,
      HabitCompletion,
      $$HabitCompletionsTableFilterComposer,
      $$HabitCompletionsTableOrderingComposer,
      $$HabitCompletionsTableAnnotationComposer,
      $$HabitCompletionsTableCreateCompanionBuilder,
      $$HabitCompletionsTableUpdateCompanionBuilder,
      (HabitCompletion, $$HabitCompletionsTableReferences),
      HabitCompletion,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$AchievementEntriesTableCreateCompanionBuilder =
    AchievementEntriesCompanion Function({
      required String key,
      Value<int> progress,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });
typedef $$AchievementEntriesTableUpdateCompanionBuilder =
    AchievementEntriesCompanion Function({
      Value<String> key,
      Value<int> progress,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });

class $$AchievementEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementEntriesTable> {
  $$AchievementEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementEntriesTable> {
  $$AchievementEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementEntriesTable> {
  $$AchievementEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementEntriesTable,
          AchievementEntry,
          $$AchievementEntriesTableFilterComposer,
          $$AchievementEntriesTableOrderingComposer,
          $$AchievementEntriesTableAnnotationComposer,
          $$AchievementEntriesTableCreateCompanionBuilder,
          $$AchievementEntriesTableUpdateCompanionBuilder,
          (
            AchievementEntry,
            BaseReferences<
              _$AppDatabase,
              $AchievementEntriesTable,
              AchievementEntry
            >,
          ),
          AchievementEntry,
          PrefetchHooks Function()
        > {
  $$AchievementEntriesTableTableManager(
    _$AppDatabase db,
    $AchievementEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementEntriesCompanion(
                key: key,
                progress: progress,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<int> progress = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementEntriesCompanion.insert(
                key: key,
                progress: progress,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementEntriesTable,
      AchievementEntry,
      $$AchievementEntriesTableFilterComposer,
      $$AchievementEntriesTableOrderingComposer,
      $$AchievementEntriesTableAnnotationComposer,
      $$AchievementEntriesTableCreateCompanionBuilder,
      $$AchievementEntriesTableUpdateCompanionBuilder,
      (
        AchievementEntry,
        BaseReferences<
          _$AppDatabase,
          $AchievementEntriesTable,
          AchievementEntry
        >,
      ),
      AchievementEntry,
      PrefetchHooks Function()
    >;
typedef $$DailyCheckInsTableCreateCompanionBuilder =
    DailyCheckInsCompanion Function({
      required String dayKey,
      required int energy,
      required int load,
      required int mood,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DailyCheckInsTableUpdateCompanionBuilder =
    DailyCheckInsCompanion Function({
      Value<String> dayKey,
      Value<int> energy,
      Value<int> load,
      Value<int> mood,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$DailyCheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get load => $composableBuilder(
    column: $table.load,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get load => $composableBuilder(
    column: $table.load,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<int> get energy =>
      $composableBuilder(column: $table.energy, builder: (column) => column);

  GeneratedColumn<int> get load =>
      $composableBuilder(column: $table.load, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DailyCheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyCheckInsTable,
          DailyCheckIn,
          $$DailyCheckInsTableFilterComposer,
          $$DailyCheckInsTableOrderingComposer,
          $$DailyCheckInsTableAnnotationComposer,
          $$DailyCheckInsTableCreateCompanionBuilder,
          $$DailyCheckInsTableUpdateCompanionBuilder,
          (
            DailyCheckIn,
            BaseReferences<_$AppDatabase, $DailyCheckInsTable, DailyCheckIn>,
          ),
          DailyCheckIn,
          PrefetchHooks Function()
        > {
  $$DailyCheckInsTableTableManager(_$AppDatabase db, $DailyCheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyCheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyCheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyCheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> dayKey = const Value.absent(),
                Value<int> energy = const Value.absent(),
                Value<int> load = const Value.absent(),
                Value<int> mood = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsCompanion(
                dayKey: dayKey,
                energy: energy,
                load: load,
                mood: mood,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dayKey,
                required int energy,
                required int load,
                required int mood,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsCompanion.insert(
                dayKey: dayKey,
                energy: energy,
                load: load,
                mood: mood,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyCheckInsTable,
      DailyCheckIn,
      $$DailyCheckInsTableFilterComposer,
      $$DailyCheckInsTableOrderingComposer,
      $$DailyCheckInsTableAnnotationComposer,
      $$DailyCheckInsTableCreateCompanionBuilder,
      $$DailyCheckInsTableUpdateCompanionBuilder,
      (
        DailyCheckIn,
        BaseReferences<_$AppDatabase, $DailyCheckInsTable, DailyCheckIn>,
      ),
      DailyCheckIn,
      PrefetchHooks Function()
    >;
typedef $$RecoveryDayEntriesTableCreateCompanionBuilder =
    RecoveryDayEntriesCompanion Function({
      required String dayKey,
      required String status,
      Value<int> riskScore,
      Value<String> reasons,
      Value<String> suggestedHabitIds,
      Value<bool> lightPlanAccepted,
      Value<DateTime?> lightPlanAcceptedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RecoveryDayEntriesTableUpdateCompanionBuilder =
    RecoveryDayEntriesCompanion Function({
      Value<String> dayKey,
      Value<String> status,
      Value<int> riskScore,
      Value<String> reasons,
      Value<String> suggestedHabitIds,
      Value<bool> lightPlanAccepted,
      Value<DateTime?> lightPlanAcceptedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$RecoveryDayEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $RecoveryDayEntriesTable> {
  $$RecoveryDayEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasons => $composableBuilder(
    column: $table.reasons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suggestedHabitIds => $composableBuilder(
    column: $table.suggestedHabitIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lightPlanAccepted => $composableBuilder(
    column: $table.lightPlanAccepted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lightPlanAcceptedAt => $composableBuilder(
    column: $table.lightPlanAcceptedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecoveryDayEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecoveryDayEntriesTable> {
  $$RecoveryDayEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasons => $composableBuilder(
    column: $table.reasons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suggestedHabitIds => $composableBuilder(
    column: $table.suggestedHabitIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lightPlanAccepted => $composableBuilder(
    column: $table.lightPlanAccepted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lightPlanAcceptedAt => $composableBuilder(
    column: $table.lightPlanAcceptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecoveryDayEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecoveryDayEntriesTable> {
  $$RecoveryDayEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get riskScore =>
      $composableBuilder(column: $table.riskScore, builder: (column) => column);

  GeneratedColumn<String> get reasons =>
      $composableBuilder(column: $table.reasons, builder: (column) => column);

  GeneratedColumn<String> get suggestedHabitIds => $composableBuilder(
    column: $table.suggestedHabitIds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get lightPlanAccepted => $composableBuilder(
    column: $table.lightPlanAccepted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lightPlanAcceptedAt => $composableBuilder(
    column: $table.lightPlanAcceptedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RecoveryDayEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecoveryDayEntriesTable,
          RecoveryDayEntry,
          $$RecoveryDayEntriesTableFilterComposer,
          $$RecoveryDayEntriesTableOrderingComposer,
          $$RecoveryDayEntriesTableAnnotationComposer,
          $$RecoveryDayEntriesTableCreateCompanionBuilder,
          $$RecoveryDayEntriesTableUpdateCompanionBuilder,
          (
            RecoveryDayEntry,
            BaseReferences<
              _$AppDatabase,
              $RecoveryDayEntriesTable,
              RecoveryDayEntry
            >,
          ),
          RecoveryDayEntry,
          PrefetchHooks Function()
        > {
  $$RecoveryDayEntriesTableTableManager(
    _$AppDatabase db,
    $RecoveryDayEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecoveryDayEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecoveryDayEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecoveryDayEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> dayKey = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> riskScore = const Value.absent(),
                Value<String> reasons = const Value.absent(),
                Value<String> suggestedHabitIds = const Value.absent(),
                Value<bool> lightPlanAccepted = const Value.absent(),
                Value<DateTime?> lightPlanAcceptedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveryDayEntriesCompanion(
                dayKey: dayKey,
                status: status,
                riskScore: riskScore,
                reasons: reasons,
                suggestedHabitIds: suggestedHabitIds,
                lightPlanAccepted: lightPlanAccepted,
                lightPlanAcceptedAt: lightPlanAcceptedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dayKey,
                required String status,
                Value<int> riskScore = const Value.absent(),
                Value<String> reasons = const Value.absent(),
                Value<String> suggestedHabitIds = const Value.absent(),
                Value<bool> lightPlanAccepted = const Value.absent(),
                Value<DateTime?> lightPlanAcceptedAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RecoveryDayEntriesCompanion.insert(
                dayKey: dayKey,
                status: status,
                riskScore: riskScore,
                reasons: reasons,
                suggestedHabitIds: suggestedHabitIds,
                lightPlanAccepted: lightPlanAccepted,
                lightPlanAcceptedAt: lightPlanAcceptedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecoveryDayEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecoveryDayEntriesTable,
      RecoveryDayEntry,
      $$RecoveryDayEntriesTableFilterComposer,
      $$RecoveryDayEntriesTableOrderingComposer,
      $$RecoveryDayEntriesTableAnnotationComposer,
      $$RecoveryDayEntriesTableCreateCompanionBuilder,
      $$RecoveryDayEntriesTableUpdateCompanionBuilder,
      (
        RecoveryDayEntry,
        BaseReferences<
          _$AppDatabase,
          $RecoveryDayEntriesTable,
          RecoveryDayEntry
        >,
      ),
      RecoveryDayEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$UserProgressEntriesTableTableManager get userProgressEntries =>
      $$UserProgressEntriesTableTableManager(_db, _db.userProgressEntries);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitSchedulesTableTableManager get habitSchedules =>
      $$HabitSchedulesTableTableManager(_db, _db.habitSchedules);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(_db, _db.habitCompletions);
  $$AchievementEntriesTableTableManager get achievementEntries =>
      $$AchievementEntriesTableTableManager(_db, _db.achievementEntries);
  $$DailyCheckInsTableTableManager get dailyCheckIns =>
      $$DailyCheckInsTableTableManager(_db, _db.dailyCheckIns);
  $$RecoveryDayEntriesTableTableManager get recoveryDayEntries =>
      $$RecoveryDayEntriesTableTableManager(_db, _db.recoveryDayEntries);
}
