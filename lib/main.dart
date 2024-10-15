import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_bloc_login/pages/AuthPage.dart';

import 'Service/AuthService.dart';
import 'bloc/AuthBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return MaterialApp(
      title: 'Authentication App',
      home: BlocProvider(
        create: (context) => AuthBloc(authService),
        child: AuthPage(),
      ),
    );
  }
}
