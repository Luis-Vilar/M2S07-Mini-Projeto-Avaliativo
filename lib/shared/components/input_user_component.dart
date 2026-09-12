import 'package:flutter/material.dart';

class InputUserComponent extends StatelessWidget {
  const new({super.key, required this.userController});

  final TextEditingController userController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Informe o usuário';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Usuario',
        prefixIcon: const Icon(Icons.person_outline),
      ),
    );
  }
}
