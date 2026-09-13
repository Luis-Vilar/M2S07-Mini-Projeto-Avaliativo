import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/confirm_dialog.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/view_models/bloc/todos_bloc.dart';

class ListCardComponent extends StatelessWidget {
  const new({super.key, required this.todo, required this.listViewContext});

  final TodoModel todo;
  final BuildContext listViewContext;

  void _showDeleteDialog() => confirmDialog(
    context: listViewContext,
    action: () =>
        listViewContext.read<TodosBloc>().add(TodosDeleteEvent(id: todo.id)),
    titleText: 'Deletar tarefa?',
    contentText: 'Tem certeza que deseja deletar a tarefa?',
    notConfirmButtonText: 'Cancelar',
    confirmButtonText: 'Deletar',
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: todo.completed,
        controlAffinity: .leading,
        title: Text(
          todo.todo,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            decoration: todo.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            overflow: .ellipsis,
          ),
        ),
        subtitle: Text('ID da Tarefa: ${todo.id}'),
        secondary: IconButton(
          onPressed: _showDeleteDialog,
          icon: Icon(Icons.delete, color: Colors.redAccent),
        ),
        onChanged: (completed) {
          if (completed == null) return;
          listViewContext.read<TodosBloc>().add(
            TodosUpdateEvent(
              todo: TodoModel(
                id: todo.id,
                todo: todo.todo,
                completed: completed,
                userId: todo.userId,
              ),
            ),
          );
        },
      ),
    );
  }
}
