import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topicos/login/login.dart';
import 'package:topicos/sign_in/view/sign_in_route.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: SignInPage.path,
  routes: [
    GoRoute(
      path: SignInPage.path,
      pageBuilder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: LoginPage.path,
      pageBuilder: (context, state) => const LoginPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      routerConfig: _router,
    );
  }
}
