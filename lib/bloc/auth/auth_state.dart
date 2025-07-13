// lib/views/auth/cubit/auth_state.dart
import 'package:ecommerce_app/models/user_profile_model.dart';


abstract class AuthState {
  const AuthState();
}

class AuthInitial   extends AuthState { const AuthInitial(); }
class AuthLoading   extends AuthState { const AuthLoading(); }

/// SUCCESS now includes the user
class AuthSuccess   extends AuthState {
  final UserProfile user;
  const AuthSuccess(this.user);
}

class AuthError     extends AuthState {
  final String message;
  const AuthError(this.message);
}
