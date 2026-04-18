import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../features/achievements/domain/achievement_repository.dart';
import '../features/habits/domain/habit_repository.dart';
import '../features/profile/domain/progress_repository.dart';
import '../features/recovery/domain/recovery_repository.dart';
import 'app_scope.dart';
import 'app_status_cubit.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class ProductiveHabitsApp extends StatefulWidget {
  const ProductiveHabitsApp({
    required this.scope,
    super.key,
  });

  final AppScope scope;

  @override
  State<ProductiveHabitsApp> createState() => _ProductiveHabitsAppState();
}

class _ProductiveHabitsAppState extends State<ProductiveHabitsApp> {
  late final GoRouter _router = createAppRouter(widget.scope);

  @override
  void dispose() {
    _router.dispose();
    widget.scope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppScope>.value(value: widget.scope),
        RepositoryProvider<HabitRepository>.value(value: widget.scope.habitRepository),
        RepositoryProvider<ProgressRepository>.value(value: widget.scope.progressRepository),
        RepositoryProvider<RecoveryRepository>.value(value: widget.scope.recoveryRepository),
        RepositoryProvider<AchievementRepository>.value(
          value: widget.scope.achievementRepository,
        ),
      ],
      child: BlocProvider<AppStatusCubit>.value(
        value: widget.scope.appStatusCubit,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Habit Quest',
          locale: const Locale('ru'),
          supportedLocales: const [
            Locale('ru'),
            Locale('en'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: buildAppTheme(),
          routerConfig: _router,
        ),
      ),
    );
  }
}
