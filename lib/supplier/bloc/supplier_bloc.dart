import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos/supplier/bloc/supplier_event.dart';
import 'package:topicos/supplier/bloc/supplier_state.dart';
import 'package:topicos/supplier/models/supplier_model.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(const SupplierState.initial()) {
    on<SupplierRequested>(_onSupplierRequested);
    on<SupplierNameChanged>(_onSupplierNameChanged);
    on<SupplierRutChanged>(_onSupplierRutChanged);
    on<SupplierScoreChanged>(_onSupplierScoreChanged);
  }

  FutureOr<void> _onSupplierRequested(
      /*
      SupplierRequested event, Emitter<SupplierState> emit) async {
    try {
      var client = http.Client();
      var data = await client.fetchData(
        url: 'http://localhost:8080/providers',
      );

        final parsed = json.decode(data.values.toString());
        final list = parsed.map<Supplier>((data) => Supplier.fromJson(data)).toList();

        emit(state.copyWith(suppliers:list));

    } on Exception {
      //emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  */
      SupplierRequested event,
      Emitter<SupplierState> emit) {
    final List<Supplier> suppliers = [
      Supplier(name: "Proveedor A", score: '5', type: "Tipo 1", rut: '12443'),
      Supplier(name: "Proveedor B", score: '8', type: "Tipo 2", rut: '12243'),
      Supplier(name: "Proveedor C", score: '3', type: "Tipo 3", rut: '12123'),
    ];
    emit(state.copyWith(suppliers: suppliers));
  }

  FutureOr<void> _onSupplierNameChanged(
      SupplierNameChanged event, Emitter<SupplierState> emit) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onSupplierRutChanged(
      SupplierRutChanged event, Emitter<SupplierState> emit) {
    emit(state.copyWith(rut: event.rut));
  }

  FutureOr<void> _onSupplierScoreChanged(
      SupplierScoreChanged event, Emitter<SupplierState> emit) {
    emit(state.copyWith(score: event.score));
  }
}
