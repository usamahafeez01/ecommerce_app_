// lib/bloc/profile/profile_state.dart
import 'package:ecommerce_app/models/user_profile_model.dart';
import 'package:ecommerce_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final UserProfile? user;

  const ProfileState({
    this.isLoading = false,
    this.error,
    this.user,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    UserProfile? user,
  }) =>
      ProfileState(
        isLoading: isLoading ?? this.isLoading,
        error: error,
        user: user ?? this.user,
      );

  factory ProfileState.initial() => const ProfileState();
}



class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileState.initial());

  final UserRepository _repo;

  Future<void> load(int userId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await _repo.fetchUser(userId);
      emit(state.copyWith(isLoading: false, user: user));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
