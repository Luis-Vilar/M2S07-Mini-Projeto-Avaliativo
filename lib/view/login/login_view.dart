import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/routes.dart';
import 'package:todo_app/shared/components/login_form_component.dart';
import 'package:todo_app/view/splash_screen/splash_view.dart';
import 'package:todo_app/view_models/bloc/login_bloc.dart';

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
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc()..add(CheckSessionEvent()),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.logged,
                arguments: state.userLoggedModel,
              );
            } else if (state is LoginError) {
              String message = state.message.toString();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Não foi possível iniciar sessão $message'),
                ),
              );
            }
          },
          builder: (context, state) {
            return switch (state) {
              LoginLoading() => const SplashView(),
              _ => LoginFormComponent(
                userController: userController,
                passwordController: passwordController,
              ),
            };
          },
        ),
      ),
    );
  }
}
