import 'package:todo_app/shared/data/models/todo/todo_model.dart';

abstract class TodoRepositoryInterface {
  Future<void> insertTodo(TodoModel todo);
  Future<List<TodoModel>> getTodos();
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
  Future<void> deleteTodos();
}
