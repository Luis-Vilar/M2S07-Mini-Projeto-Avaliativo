import 'package:flutter/material.dart';
import 'package:todo_app/view/splash_screen/splash_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SplashView());
  }
}
