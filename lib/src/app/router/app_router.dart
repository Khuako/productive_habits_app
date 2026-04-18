import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/habits/presentation/habit_form_screen.dart';
import '../../features/habits/presentation/habits_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/statistics/presentation/stats_screen.dart';
import '../app_scope.dart';
import '../widgets/app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root-router',
);

GoRouter createAppRouter(AppScope scope) {
  final refreshStream = GoRouterRefreshStream(scope.appStatusCubit.stream);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/loading',
    refreshListenable: refreshStream,
    redirect: (context, state) {
      final appState = scope.appStatusCubit.state;
      final isLoading = state.matchedLocation == '/loading';
      final isOnboarding = state.matchedLocation == '/onboarding';

      if (appState.isLoading) {
        return isLoading ? null : '/loading';
      }

      if (!appState.isOnboardingCompleted) {
        return isOnboarding ? null : '/onboarding';
      }

      if (isLoading || isOnboarding) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const _LoadingScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => BlocProvider(
          create: (context) => OnboardingCubit(
            recommendationEngine: scope.recommendationEngine,
            habitRepository: scope.habitRepository,
            progressRepository: scope.progressRepository,
          )..load(),
          child: const OnboardingScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => BlocProvider(
                  create: (context) => DashboardCubit(
                    habitRepository: scope.habitRepository,
                    progressRepository: scope.progressRepository,
                    achievementRepository: scope.achievementRepository,
                    recoveryRepository: scope.recoveryRepository,
                  )..start(),
                  child: const DashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/habits',
                builder: (context, state) => BlocProvider(
                  create: (context) => HabitsCubit(
                    habitRepository: scope.habitRepository,
                  )..start(),
                  child: const HabitsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stats',
                builder: (context, state) => BlocProvider(
                  create: (context) => StatsCubit(
                    progressRepository: scope.progressRepository,
                    achievementRepository: scope.achievementRepository,
                  )..start(),
                  child: const StatsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => BlocProvider(
                  create: (context) => ProfileCubit(
                    progressRepository: scope.progressRepository,
                    habitRepository: scope.habitRepository,
                    reminderService: scope.reminderService,
                  )..start(),
                  child: const ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/habit/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const HabitFormScreen(),
      ),
      GoRoute(
        path: '/habit/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => HabitFormScreen(
          habitId: int.tryParse(state.pathParameters['id'] ?? ''),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Не удалось открыть экран.\n${state.error}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
