import 'package:todo_app/shared/data/models/todo/todo_model.dart';

abstract class CrudTodoInterface {
  Future<void> createTodo(TodoModel todo);
  Future<List<TodoModel>> readTodos();
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
  Future<void> deleteAllTodos();
}
