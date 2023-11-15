import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
}

class CompanyQuestionChanged extends CompanyEvent {
  const CompanyQuestionChanged({
    required this.question,
  });

  final String question;
  @override
  List<Object?> get props => [question];
}
