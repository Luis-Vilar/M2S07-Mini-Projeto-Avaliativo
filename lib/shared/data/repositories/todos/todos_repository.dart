import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/interfaces/crud_todo_repository.dart';
import 'package:todo_app/shared/interfaces/todo_repository.dart';
import 'package:todo_app/shared/interfaces/todo_source.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

class TodosRepository implements TodoRepositoryInterface {
  final _todoCrud = injection.get<CrudTodoInterface>();
  final _todoSource = injection.get<TodoSourceInterface>();

  @override
  Future<void> insertTodos(List<TodoModel> todos) async {
    for (final todo in todos) {
      await _todoCrud.insertTodo(todo);
    }
  }

  @override
  Future<void> insertTodo(TodoModel todo) => _todoCrud.insertTodo(todo);

  @override
  Future<List<TodoModel>> getTodos() => _todoCrud.getTodos();

  @override
  Future<void> updateTodo(TodoModel todo) => _todoCrud.updateTodo(todo);

  @override
  Future<void> deleteTodo(int id) => _todoCrud.deleteTodo(id);

  @override
  Future<Result<List<TodoModel>>> syncTodos(int userId) async {
    final localTodos = await getTodos();
    final hasTodosFromAnotherUser = localTodos.any(
      (todo) => todo.userId != userId,
    );

    if (hasTodosFromAnotherUser) {
      await deleteTodos();
    }

    final result = await _todoSource.getTodos(userId);
    if (result is Ok<List<TodoModel>>) {
      await insertTodos(result.value);
      return Result.ok(await getTodos());
    }
    return result;
  }

  @override
  Future<void> deleteTodos() => _todoCrud.deleteTodos();
}
