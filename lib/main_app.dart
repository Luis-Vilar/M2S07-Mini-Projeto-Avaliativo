import 'package:flutter/material.dart';
import 'package:todo_app/core/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: AppRoutes.routes, initialRoute: AppRoutes.login);
  }
}
