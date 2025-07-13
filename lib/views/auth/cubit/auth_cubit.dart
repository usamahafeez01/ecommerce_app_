// lib/bloc/auth/auth_cubit.dart
// ignore_for_file: depend_on_referenced_packages

import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/models/login_model.dart';
import 'package:ecommerce_app/models/user_profile_model.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authService) : super(const AuthInitial());

  /* ------------------------------------------------------------------ */
  /* Dependencies                                                       */
  /* ------------------------------------------------------------------ */
  final AuthService _authService;
  final _secure = const FlutterSecureStorage();

  /* ------------------------------------------------------------------ */
  /* Login                                                              */
  /* ------------------------------------------------------------------ */

Future<void> login(String username, String password) async {
  emit(const AuthLoading());

  try {
    // 1️⃣  make the /auth/login call (returns token, maybe user)
    final req = LoginRequest(username: username, password: password);
    final res = await _authService.login(req);

    // 2️⃣  store the token securely no matter what
    await _secure.write(key: 'token', value: res.token);

    // 3️⃣  if the server already sent the profile, we’re done
    if (res.user != null) {
      emit(AuthSuccess(res.user!));
      return;
    }

    // 4️⃣  otherwise (token‑only back‑end like FakeStore) fetch the profile
    //     – you can decode the JWT or map the demo username → id
    final int profileId = _authService.resolveFakeStoreId(username);
    final profile       = await _authService.fetchUser(profileId);

    emit(AuthSuccess(profile));
  } catch (e, s) {
    debugPrint('LOGIN ERROR → $e');
    debugPrintStack(stackTrace: s);
    emit(const AuthError('Login failed. Please check credentials.'));
  }
}

  /* ------------------------------------------------------------------ */
  /* Logout                                                             */
  /* ------------------------------------------------------------------ */
  Future<void> logout() async {
    await _secure.delete(key: 'token');
    emit(const AuthInitial());
  }

  /* ------------------------------------------------------------------ */
  /* Helpers                                                            */
  /* ------------------------------------------------------------------ */
  Future<String?> getStoredToken() => _secure.read(key: 'token');

  /// Returns the signed‑in user or null if not authenticated.
  UserProfile? get currentUser =>
      state is AuthSuccess ? (state as AuthSuccess).user : null;



void validationError(String message) {
  emit(AuthError(message));
}


}

