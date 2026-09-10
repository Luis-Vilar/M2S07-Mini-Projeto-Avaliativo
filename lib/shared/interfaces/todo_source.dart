import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/result_pattern.dart';

abstract class TodoSourceInterface {
  Future<Result<List<TodoModel>>> getTodos(int userId);
}
