import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/profile/domain/profile_models.dart';
import '../features/profile/domain/progress_repository.dart';

class AppStatusState extends Equatable {
  const AppStatusState({
    required this.isLoading,
    required this.profile,
  });

  const AppStatusState.loading()
      : isLoading = true,
        profile = null;

  final bool isLoading;
  final UserProfile? profile;

  bool get isOnboardingCompleted => profile?.onboardingCompleted ?? false;

  @override
  List<Object?> get props => [isLoading, profile];
}

class AppStatusCubit extends Cubit<AppStatusState> {
  AppStatusCubit(this._progressRepository) : super(const AppStatusState.loading());

  final ProgressRepository _progressRepository;
  StreamSubscription<UserProfile?>? _subscription;

  void start() {
    _subscription?.cancel();
    emit(const AppStatusState.loading());
    _subscription = _progressRepository.watchUserProfile().listen(
      (profile) => emit(
        AppStatusState(
          isLoading: false,
          profile: profile,
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
