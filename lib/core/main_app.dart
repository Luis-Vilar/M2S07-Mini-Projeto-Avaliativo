import 'package:flutter/material.dart';
import 'package:todo_app/core/dark_theme.dart';
import 'package:todo_app/core/routes.dart';
import 'package:todo_app/core/light_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.login,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
