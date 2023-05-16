import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "Twitter",
      theme: AppTheme.theme,
      home: Scaffold(
        body: Center(
          child: ref
              .watch(
                currentUserAccProvider,
              )
              .when(
                data: (user) {
                  if (user != null) {
                    return const HomeView();
                  }
                  return const SignupView();
                },
                error: (error, st) => ErrorPage(
                  error: error.toString(),
                ),
                loading: () => const LoadingPage(),
              ),
        ),
      ),
    );
  }
}
