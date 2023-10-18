import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topicos/company/view/company_page.dart';
import 'package:topicos/home/view/home_page.dart';
import 'package:topicos/login/login.dart';
import 'package:topicos/sign_in/view/sign_in_route.dart';
import 'package:topicos/supplier/view/view.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: HomePage.path,
  routes: [
    GoRoute(
      path: SignInPage.path,
      pageBuilder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: LoginPage.path,
      pageBuilder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: HomePage.path,
      pageBuilder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: SupplierPage.path,
      pageBuilder: (context, state) => const SupplierPage(),
    ),
    GoRoute(
      path: CompanyPage.path,
      pageBuilder: (context, state) => const CompanyPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      routerConfig: _router,
    );
  }
}
