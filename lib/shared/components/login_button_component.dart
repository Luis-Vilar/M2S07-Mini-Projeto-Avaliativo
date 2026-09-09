import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/interfases/auth.dart';
import 'package:todo_app/shared/result_pattern.dart';

class LoginButtonComponent extends StatelessWidget {
  LoginButtonComponent({
    super.key,
    required this.userController,
    required this.passwordController,
  });

  final TextEditingController userController;
  final TextEditingController passwordController;
  final auth = injection.get<AuthInterfase>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () async {
          final user = UserLoginModel(
            username: userController.text,
            password: passwordController.text,
          );
          final loginResult = await auth.login(user);

          if (loginResult case Ok(:final value)) {
            log(value.toString());
          } else if (loginResult case ResultError(:final error)) {
            log(error.toString());
          }

          userController.clear();
          passwordController.clear();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Fazer Login',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
