import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/interfaces/todo_repository.dart';
import 'package:todo_app/shared/interfaces/todo_source.dart';
import 'package:todo_app/shared/result_pattern.dart';

class TodosRepository {
  final _todoRepository = injection.get<TodoRepositoryInterface>();
  final _todoSource = injection.get<TodoSourceInterface>();

  Future<void> insertTodos(List<TodoModel> todos) async {
    for (final todo in todos) {
      await _todoRepository.insertTodo(todo);
    }
  }

  Future<void> insertTodo(TodoModel todo) => _todoRepository.insertTodo(todo);

  Future<List<TodoModel>> getTodos() => _todoRepository.getTodos();

  Future<void> updateTodo(TodoModel todo) => _todoRepository.updateTodo(todo);

  Future<void> deleteTodo(int id) => _todoRepository.deleteTodo(id);

  Future<Result<List<TodoModel>>> syncTodos() async {
    final result = await _todoSource.getTodos();
    if (result is Ok<List<TodoModel>>) {
      await insertTodos(result.value);
      return Result.ok(await getTodos());
    }
    return result;
  }
}
