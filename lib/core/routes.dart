import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view/login/login_view.dart';
import 'package:todo_app/view_models/bloc/login_bloc.dart';

class AppRoutes {
  static const String login = '/login';

  static final routes = <String, Widget Function(BuildContext)>{
    login: (context) =>
        BlocProvider(create: (context) => LoginBloc(), child: LoginView()),
  };
}
