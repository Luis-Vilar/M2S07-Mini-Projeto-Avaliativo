import 'dart:developer';

import 'package:flutter/material.dart';

class LoginButtonComponent extends StatelessWidget {
  const new({
    super.key,
    required this.userController,
    required this.passwordController,
  });

  final TextEditingController userController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          log(userController.text);
          log(passwordController.text);
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
