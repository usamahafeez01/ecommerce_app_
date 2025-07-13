import 'package:ecommerce_app/views/auth/cubit/auth_cubit.dart';

class LoginViewModel {
  final AuthCubit authCubit;
  LoginViewModel(this.authCubit);

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      // tell cubit to emit an error via a *public* method
      authCubit.validationError("Username and password can't be empty.");
      return;
    }

    await authCubit.login(username, password); // let cubit handle everything
  }

  Future<String?> getToken() => authCubit.getStoredToken();
  Future<void> logout()       => authCubit.logout();
}
