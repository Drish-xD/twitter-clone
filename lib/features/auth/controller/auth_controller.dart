import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/api/auth_api.dart';
import 'package:twitter_clone/api/user_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApi: ref.watch(authApiProvider),
    userApi: ref.watch(userApiProvider),
  );
});

final currentUserAccProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserApi _userApi;
  AuthController({required AuthApi authApi, required UserApi userApi})
      : _authApi = authApi,
        _userApi = userApi,
        super(false);

  Future<Account?> currentUser() => _authApi.currentUserAcc();

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
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          uid: '',
          bio: '',
          isTwitterBlue: false,
        );
        final res = await _userApi.saveUserData(userModel);
        res.fold(
          (l) => showSnackBar(content: l.message, context: context),
          (r) {
            showSnackBar(
                context: context, content: "Account Created! Please Login.");
            Navigator.push(context, LoginView.route());
          },
        );
      },
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
      (r) {
        showSnackBar(context: context, content: "Logged In .");
        Navigator.push(context, HomeView.route());
      },
    );
  }
}
