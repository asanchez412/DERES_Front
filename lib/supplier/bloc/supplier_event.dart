import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SupplierEvent extends Equatable {
  const SupplierEvent();
}

class SupplierRequested extends SupplierEvent {
  const SupplierRequested();

  @override
  List<Object?> get props => [];
}
