import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topicos/login/view/view.dart';
import 'package:topicos/sign_in/view/sign_in_route.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text('Welcome!'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go(LoginPage.path),
                    child: const Text('Tap to log in'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => context.go(SignInPage.path),
                    child: const Text('Tap to Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
