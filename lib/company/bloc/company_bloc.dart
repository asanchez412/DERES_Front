import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos/company/bloc/company_event.dart';
import 'package:topicos/company/bloc/company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(const CompanyState.initial()) {
    on<CompanyQuestionChanged>(_onQuestionChanged);
  }

  FutureOr<void> _onQuestionChanged(
      CompanyQuestionChanged event, Emitter<CompanyState> emit) {}
}
