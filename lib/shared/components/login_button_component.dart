import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/view_models/bloc/login_bloc.dart';

class LoginButtonComponent extends StatefulWidget {
  const LoginButtonComponent({
    super.key,
    required this.formKey,
    required this.userController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController passwordController;

  @override
  State<LoginButtonComponent> createState() => _LoginButtonComponentState();
}

class _LoginButtonComponentState extends State<LoginButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (!(widget.formKey.currentState?.validate() ?? false)) return;

              context.read<LoginBloc>().add(
                LoginUserEvent(
                  user: UserLoginModel(
                    username: widget.userController.text,
                    password: widget.passwordController.text,
                  ),
                ),
              );
              widget.userController.clear();
              widget.passwordController.clear();
            },
            child: const Text('Fazer Login'),
          ),
        );
      },
    );
  }
}
