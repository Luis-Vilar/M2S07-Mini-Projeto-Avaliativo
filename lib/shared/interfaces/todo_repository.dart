import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

abstract class TodoRepositoryInterface {
  Future<void> insertTodos(List<TodoModel> todos);
  Future<void> insertTodo(TodoModel todo);
  Future<List<TodoModel>> getTodos();
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
  Future<Result<List<TodoModel>>> syncTodos(int userId);
  Future<void> deleteTodos();
}
