import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:topicos/sign_in/sign_in.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Account registered successfully')),
            );
          if (context.canPop()) {
            context.pop();
          } else {
            //context.go(HomePage.path);
          }
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong')),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign in')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: const [
            EmailTextField(),
            SizedBox(height: 24),
            PasswordTextField(),
            SizedBox(height: 24),
            ConfirmationPasswordTextField(),
            SizedBox(height: 24),
            SignInButton(),
          ],
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final valid = context.select((SignInBloc bloc) => bloc.emailIsValid);

    return TextField(
      onChanged: (value) =>
          context.read<SignInBloc>().add(SignInEmailChanged(value)),
      decoration: InputDecoration(
        hintText: 'Email',
        errorText: valid ? null : 'Please enter a valid email',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final obscurePassword =
        context.select((SignInBloc bloc) => bloc.obscurePassowrds);

    final valid = context.select((SignInBloc bloc) => bloc.passwordIsValid);

    return TextField(
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (value) =>
          context.read<SignInBloc>().add(SignInPasswordChanged(value)),
      decoration: InputDecoration(
        hintText: 'Password',
        errorText: valid ? null : 'Password must be at least 6 characters long',
        suffixIcon: IconButton(
          icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            context.read<SignInBloc>().add(
                  SignInPasswordVisibilityChanged(obscure: !obscurePassword),
                );
          },
        ),
      ),
      enableIMEPersonalizedLearning: false,
      obscureText: obscurePassword,
    );
  }
}

class ConfirmationPasswordTextField extends StatelessWidget {
  const ConfirmationPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final obscurePassword =
        context.select((SignInBloc bloc) => bloc.obscurePassowrds);

    final valid = context.select((SignInBloc bloc) => bloc.passwordsMatch);

    return TextField(
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (value) => context.read<SignInBloc>().add(
            SignInConfirmationPasswordChanged(value),
          ),
      decoration: InputDecoration(
        hintText: 'Password confirmation',
        errorText: valid ? null : 'Passwords do not match',
        suffixIcon: IconButton(
          icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            context.read<SignInBloc>().add(
                  SignInPasswordVisibilityChanged(obscure: !obscurePassword),
                );
          },
        ),
      ),
      enableIMEPersonalizedLearning: false,
      obscureText: obscurePassword,
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final validToSubmit = context.select((SignInBloc bloc) => bloc.valid);

    return ElevatedButton(
      onPressed: validToSubmit
          ? () {
              context
                  .read<SignInBloc>()
                  .add(const SignInWithEmailAndPasswordRequested());
            }
          : null,
      child: const Text('Sign in'),
    );
  }
}
