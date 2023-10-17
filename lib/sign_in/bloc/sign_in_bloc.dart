import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos/form_inputs/lib/form_inputs.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc()
      :
        //_authenticationClient = authenticationClient,
        super(const SignInState.initial()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInConfirmationPasswordChanged>(_onConfirmationPasswordChanged);
    on<SignInPasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<SignInWithEmailAndPasswordRequested>(
      _onSignInWithEmailAndPasswordRequested,
    );
  }

  //final AuthenticationClient _authenticationClient;

  bool get valid =>
      Formz.validate([state.email, state.password]) &&
      state.password.value == state.confirmationPassword;

  bool get emailIsValid {
    final email = state.email;
    return email.isPure || email.isValid;
  }

  bool get passwordIsValid {
    final password = state.password;
    return password.isPure || password.isValid;
  }

  bool get passwordsMatch {
    final password = state.password;
    return password.isPure || password.value == state.confirmationPassword;
  }

  bool get obscurePassowrds => state.obscurePasswords;

  FutureOr<void> _onSignInWithEmailAndPasswordRequested(
    SignInWithEmailAndPasswordRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      // await _authenticationClient.registerWithEmailAndPassword(
      //   email: state.email.value,
      //   password: state.password.value,
      // );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on Exception {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }

  FutureOr<void> _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  FutureOr<void> _onPasswordVisibilityChanged(
    SignInPasswordVisibilityChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(obscurePasswords: event.obscure));
  }

  FutureOr<void> _onConfirmationPasswordChanged(
    SignInConfirmationPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(confirmationPassword: event.password));
  }
}
