import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos/admin/bloc/admin_event.dart';
import 'package:topicos/admin/bloc/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(const AdminState.initial());
}
