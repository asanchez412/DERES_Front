import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topicos/company/bloc/company_bloc.dart';
import 'package:topicos/company/view/company_view.dart';

class CompanyPage extends Page<void> {
  const CompanyPage({super.key});

  static const path = '/company';

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      settings: this,
      builder: (context) {
        return BlocProvider<CompanyBloc>(
          create: (_) {
            return CompanyBloc();
          },
          child: const CompanyView(),
        );
      },
    );
  }
}
