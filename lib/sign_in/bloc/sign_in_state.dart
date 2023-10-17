part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    required this.status,
    required this.email,
    required this.password,
    required this.confirmationPassword,
    required this.obscurePasswords,
  });

  const SignInState.initial()
      : this(
          status: FormzSubmissionStatus.initial,
          email: const Email.pure(),
          password: const Password.pure(),
          confirmationPassword: '',
          obscurePasswords: true,
        );

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final String confirmationPassword;
  final bool obscurePasswords;

  SignInState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    String? confirmationPassword,
    bool? obscurePasswords,
  }) {
    return SignInState(
      status: status ?? this.status,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      email: email ?? this.email,
      obscurePasswords: obscurePasswords ?? this.obscurePasswords,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        password,
        confirmationPassword,
        obscurePasswords,
      ];
}
