import 'package:flutter/material.dart';
import 'package:todo_app/view/logged/logged_view.dart';
import 'package:todo_app/view/login/login_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String logged = '/logged';

  static final routes = <String, Widget Function(BuildContext)>{
    login: (_) => LoginView(),
    logged: (_) => LoggedView(),
  };
}
