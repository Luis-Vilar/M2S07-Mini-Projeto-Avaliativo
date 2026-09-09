import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/input_password_component.dart';
import 'package:todo_app/shared/components/input_user_component.dart';
import 'package:todo_app/shared/components/login_button_component.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        const SizedBox(height: 60),

                        const Center(
                          child: Icon(
                            Icons.person,
                            size: 120,
                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          'Bem-vindo de volta!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28, fontWeight: .w600),
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          'Organize suas tarefas e conquiste o seu dia.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 40),

                        InputUserComponent(userController: userController),

                        const SizedBox(height: 20),

                        InputPasswordComponent(
                          passwordController: passwordController,
                        ),

                        const SizedBox(height: 35),

                        LoginButtonComponent(
                          userController: userController,
                          passwordController: passwordController,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
