import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:topicos/home/view/home_page.dart';
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
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              context.go(HomePage.path);
            },
            child: Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    image: const DecorationImage(
                        image: AssetImage('lib/assets/deres.png'),
                        fit: BoxFit.cover,
                        scale: 2),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Registrarse',
                ),
              ],
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.orangeAccent,
        ),
        body: Center(
          child: Container(
            width: 800,
            height: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const EmailTextField(),
                    const SizedBox(height: 16),
                    const PasswordTextField(),
                    const SizedBox(height: 16),
                    const ConfirmationPasswordTextField(),
                    const SizedBox(height: 32),
                    const Text(
                      "Tipo de Usuario",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                              title: const Text("Usuario"),
                              value: false,
                              onChanged: ((value) {})),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: CheckboxListTile(
                              title: const Text("Proveedor"),
                              value: false,
                              onChanged: ((value) {})),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                const SignInButton(),
              ],
            ),
          ),
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

    return OutlinedButton(
      onPressed: () {
        validToSubmit
            ? () {
                context
                    .read<SignInBloc>()
                    .add(const SignInWithEmailAndPasswordRequested());
              }
            : null;
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orangeAccent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: const Text('Registrarse'),
    );
  }
}
