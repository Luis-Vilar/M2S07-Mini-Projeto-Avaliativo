import 'package:flutter/material.dart';
import 'package:todo_app/view/login/login_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginView());
  }
}
