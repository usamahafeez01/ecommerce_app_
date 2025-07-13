import 'user_profile_model.dart';

class LoginResponse {
  /// Always present
  final String token;

  /// Present only if the back‑end includes a profile in the same payload.
  /// For FakeStore it will be null.
  final UserProfile? user;

  const LoginResponse({
    required this.token,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      user : json['user'] != null
          ? UserProfile.fromJson(json['user'] as Map<String, dynamic>)
          : null,                               // ✅ safe for {token}-only
    );
  }
  LoginResponse copyWith({
    String? token,
    UserProfile? user,
  }) =>
      LoginResponse(
        token: token ?? this.token,
        user : user  ?? this.user,
      );

}

/* ───────────────────────────── Request ───────────────────────────── */

class LoginRequest {
  final String username;
  final String password;

  const LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
