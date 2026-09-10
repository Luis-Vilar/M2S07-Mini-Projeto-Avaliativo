import 'package:todo_app/shared/data/db_helper.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/interfaces/todo_repository.dart';

class SqfliteTodoRepository implements TodoRepositoryInterface {
  @override
  Future<void> insertTodo(TodoModel todo) async {
    final db = await DbHelper.db;
    final data = {
      'id': todo.id,
      'todo': todo.todo,
      'userId': todo.userId,
      'completed': todo.completed == true ? 1 : 0,
    };
    await db.insert('todos', data);
  }

  @override
  Future<void> deleteTodo(int id) async {
    final db = await DbHelper.db;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<TodoModel>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
