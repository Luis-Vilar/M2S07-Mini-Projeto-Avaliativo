import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/routes.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/data/sources/local/shared_preferences.dart';
import 'package:todo_app/view/splash_screen/splash_view.dart';
import 'package:todo_app/view_models/bloc/todos_bloc.dart';

class LoggedView extends StatefulWidget {
  const new({super.key});

  @override
  State<LoggedView> createState() => _LoggedViewState();
}

class _LoggedViewState extends State<LoggedView> {
  bool tryAgain = false;
  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Fechar sessão'),
          content: const Text('Tem certeza que deseja fechar a sessão atual?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    await removeSessionData();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserLoggedModel;

    return BlocProvider<TodosBloc>(
      create: (_) => TodosBloc()..add(TodosSyncEvent(userId: user.id)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.image),
              onBackgroundImageError: (_, _) {},
              child: user.image.isEmpty ? const Icon(Icons.person) : null,
            ),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: .bold),
              ),
              Text(
                user.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          actions: [
            ?tryAgain
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.replay_outlined),
                    tooltip: 'Recarregar',
                    padding: const EdgeInsets.only(right: 8),
                  )
                : null,
            IconButton(
              onPressed: _showLogoutDialog,
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              padding: const EdgeInsets.only(right: 24),
            ),
          ],
        ),
        body: BlocConsumer<TodosBloc, TodosState>(
          listener: (context, state) {
            if (state is TodosError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              setState(() {
                tryAgain = true;
              });
            }
          },
          builder: (context, state) {
            return switch (state) {
              TodosLoading() => const Center(child: SplashView()),
              TodosSuccess(:final todos) when todos.isEmpty => const Center(
                child: Text('No hay tareas disponibles.'),
              ),
              TodosSuccess(:final todos) => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Card(
                    color: todo.completed ? Colors.pink[100] : Colors.white,
                    child: CheckboxListTile(
                      value: todo.completed,
                      title: Text(
                        todo.todo,
                        style: TextStyle(
                          decoration: todo.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: todo.completed ? Colors.brown : Colors.black87,
                          fontWeight: .bold,
                        ),
                      ),
                      subtitle: Text('ID da Tarefa: ${todo.id}'),
                      onChanged: (completed) {
                        if (completed == null) return;
                        context.read<TodosBloc>().add(
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
                },
              ),
              TodosError(:final message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: Text(message),
                ),
              ),
              TodosInitial() => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
