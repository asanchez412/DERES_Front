import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:topicos/supplier/models/supplier_model.dart';

@immutable
class SupplierState extends Equatable {
  const SupplierState({
    required this.suppliers,
  });

  const SupplierState.initial() : this(suppliers: const <Supplier>[]);

  final List<Supplier> suppliers;

  @override
  List<Object?> get props => [suppliers];

  SupplierState copyWith({List<Supplier>? suppliers}) {
    return SupplierState(suppliers: suppliers ?? this.suppliers);
  }
}
