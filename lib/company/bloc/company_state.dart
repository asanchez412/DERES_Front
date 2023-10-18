import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CompanyState extends Equatable {
  const CompanyState();

  const CompanyState.initial() : this();

  @override
  List<Object?> get props => [];

  CompanyState copyWith() {
    return const CompanyState();
  }
}
