import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/input_password_component.dart';
import 'package:todo_app/shared/components/input_user_component.dart';
import 'package:todo_app/shared/components/login_button_component.dart';

class LoginFormComponent extends StatelessWidget {
  const new({
    super.key,
    required this.formKey,
    required this.userController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 260,
                          height: 260,
                          fit: .contain,
                        ),
                        const Text(
                          'Bem-vindo de volta!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 28,
                            fontWeight: .w600,
                          ),
                        ),
                        const Text(
                          'Organize suas tarefas e conquiste o seu dia.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        const SizedBox(height: 20),
                        InputUserComponent(userController: userController),
                        const SizedBox(height: 20),
                        InputPasswordComponent(
                          passwordController: passwordController,
                        ),
                        const SizedBox(height: 35),
                        LoginButtonComponent(
                          formKey: formKey,
                          userController: userController,
                          passwordController: passwordController,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
