import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/api/auth_api.dart';
import 'package:twitter_clone/core/core.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApi: ref.watch(authApiProvider),
  );
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({required AuthApi authApi})
      : _authApi = authApi,
        super(false);

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;

    final res = await _authApi.signUp(
      email: email,
      password: password,
    );

    state = false;

    res.fold(
      (l) => showSnackBar(context: context, content: l.message),
      (r) => print(r.email),
    );
  }

  void logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;

    final res = await _authApi.logIn(
      email: email,
      password: password,
    );

    state = false;

    res.fold(
      (l) => showSnackBar(context: context, content: l.message),
      (r) => print(r.userId),
    );
  }
}
