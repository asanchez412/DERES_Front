import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum QuestionType { social, environmental, governance }

extension QuestionTypeName on QuestionType {
  String get name {
    switch (this) {
      case QuestionType.social:
        return 'Social';
      case QuestionType.environmental:
        return 'Ambiental';
      case QuestionType.governance:
        return 'Gobernanza';
    }
  }
}

@immutable
class AdminState extends Equatable {
  const AdminState();

  const AdminState.initial() : this();

  @override
  List<Object?> get props => [];

  AdminState copyWith() {
    return const AdminState();
  }
}
