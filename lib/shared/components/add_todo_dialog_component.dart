import 'package:flutter/material.dart';

class AddTodoDialogComponent extends StatefulWidget {
  const new({super.key});

  @override
  State<AddTodoDialogComponent> createState() => _AddTodoDialogComponentState();
}

class _AddTodoDialogComponentState extends State<AddTodoDialogComponent> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar tarefa'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Tarefa',
            hintText: 'Digite a descrição da tarefa',
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Informe a tarefa';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.pop(context, _controller.text.trim());
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
