import 'package:todo_app/shared/data/db_helper.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/interfaces/todo_repository.dart';

class SqfliteCrudTodo implements CrudTodoInterface {
  @override
  Future<void> insertTodo(TodoModel todo) async {
    final db = await DbHelper.db;
    final data = {
      'id': todo.id,
      'todo': todo.todo,
      'userId': todo.userId,
      'completed': todo.completed == true ? 1 : 0,
    };
    await db.insert('todos', data, conflictAlgorithm: .ignore);
  }

  @override
  Future<void> deleteTodo(int id) async {
    final db = await DbHelper.db;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteTodos() async {
    final db = await DbHelper.db;
    await db.delete('todos');
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    final db = await DbHelper.db;
    final rows = await db.query('todos');

    return rows
        .map(
          (row) => TodoModel(
            id: row['id'] as int,
            todo: row['todo'] as String,
            completed: (row['completed'] as int) == 1,
            userId: row['userId'] as int,
          ),
        )
        .toList();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final db = await DbHelper.db;
    await db.update(
      'todos',
      {
        'todo': todo.todo,
        'completed': todo.completed ? 1 : 0,
        'userId': todo.userId,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}
