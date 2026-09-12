import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/routes.dart';
import 'package:todo_app/shared/components/add_todo_dialog_component.dart';
import 'package:todo_app/shared/components/list_card_component.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/data/sources/local/shared_preferences.dart';
import 'package:todo_app/shared/components/todo_filter_toolbar_component.dart';
import 'package:todo_app/shared/utils/enums.dart';
import 'package:todo_app/view/splash_screen/splash_view.dart';
import 'package:todo_app/view_models/bloc/todos_bloc.dart';

class LoggedView extends StatefulWidget {
  const new({super.key});

  @override
  State<LoggedView> createState() => _LoggedViewState();
}

class _LoggedViewState extends State<LoggedView> {
  bool tryAgain = false;
  TodoFilter _filter = TodoFilter.all;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TodoModel> _filterTodos(List<TodoModel> todos) {
    final searchText = _searchController.text.trim().toLowerCase();

    return todos.where((todo) {
      final matchesStatus = switch (_filter) {
        TodoFilter.all => true,
        TodoFilter.pending => !todo.completed,
        TodoFilter.completed => todo.completed,
      };
      final matchesText = todo.todo.toLowerCase().contains(searchText);

      return matchesStatus && matchesText;
    }).toList();
  }

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

  Future<void> _showAddTodoDialog(BuildContext blocContext, int userId) async {
    final todoText = await showDialog<String>(
      context: context,
      builder: (_) => const AddTodoDialogComponent(),
    );

    if (todoText == null || todoText.isEmpty || !blocContext.mounted) return;

    blocContext.read<TodosBloc>().add(
      TodosCreateEvent(
        todo: TodoModel(
          id: DateTime.now().millisecondsSinceEpoch,
          todo: todoText,
          completed: false,
          userId: userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserLoggedModel;

    return BlocProvider<TodosBloc>(
      create: (_) => TodosBloc()..add(TodosSyncEvent(userId: user.id)),
      child: Scaffold(
        appBar: AppBar(
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
              ),
              Text(
                user.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).appBarTheme.toolbarTextStyle,
              ),
            ],
          ),
          actions: [
            ?tryAgain
                ? Builder(
                    builder: (blocContext) {
                      return IconButton(
                        onPressed: () {
                          blocContext.read<TodosBloc>().add(
                            TodosSyncEvent(userId: user.id),
                          );
                        },
                        icon: const Icon(Icons.replay_outlined),
                        tooltip: 'Recarregar',
                        padding: const EdgeInsets.only(right: 8),
                      );
                    },
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

            if (state is TodosSuccess) {
              setState(() {
                tryAgain = false;
              });
            }
          },
          builder: (context, state) {
            return switch (state) {
              TodosLoading() => const Center(child: SplashView()),
              TodosSuccess(:final todos) => _buildTodosContent(context, todos),
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
        floatingActionButton: Builder(
          builder: (blocContext) {
            return FloatingActionButton(
              onPressed: () => _showAddTodoDialog(blocContext, user.id),
              tooltip: 'Adicionar tarefa',
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTodosContent(BuildContext context, List<TodoModel> todos) {
    final filteredTodos = _filterTodos(todos);

    return Column(
      children: [
        TodoFilterToolbarComponent(
          searchController: _searchController,
          selectedFilter: _filter,
          onSearchChanged: (_) => setState(() {}),
          onClearSearch: () {
            _searchController.clear();
            setState(() {});
          },
          onFilterChanged: (filter) {
            setState(() {
              _filter = filter;
            });
          },
        ),
        Expanded(
          child: filteredTodos.isEmpty
              ? const Center(child: Text('Sem tarefas para este filtro.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredTodos.length,
                  itemBuilder: (context, index) {
                    final todo = filteredTodos[index];
                    return ListCardComponent(
                      todo: todo,
                      listViewContext: context,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
