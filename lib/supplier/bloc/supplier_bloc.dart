import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos/supplier/bloc/supplier_event.dart';
import 'package:topicos/supplier/bloc/supplier_state.dart';
import 'package:topicos/supplier/models/supplier_model.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(const SupplierState.initial()) {
    on<SupplierRequested>(_onSupplierRequested);
  
  }

  FutureOr<void> _onSupplierRequested(
      SupplierRequested event, Emitter<SupplierState> emit) {
    final List<Supplier> suppliers = [
      Supplier(name: "Proveedor A", score: 5, type: "Tipo 1"),
      Supplier(name: "Proveedor B", score: 8, type: "Tipo 2"),
      Supplier(name: "Proveedor C", score: 3, type: "Tipo 3"),
    ];
    emit(state.copyWith(suppliers: suppliers));
  }
}
