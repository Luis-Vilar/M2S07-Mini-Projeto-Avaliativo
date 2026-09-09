import 'package:flutter/material.dart';

class InputUserComponent extends StatelessWidget {
  const new({super.key, required this.userController});

  final TextEditingController userController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: userController,
      decoration: InputDecoration(
        labelText: 'Usuario',
        labelStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF64748B)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
