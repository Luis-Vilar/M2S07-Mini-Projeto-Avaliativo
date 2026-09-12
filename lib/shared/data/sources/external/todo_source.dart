import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/interfaces/http_client.dart';
import 'package:todo_app/shared/interfaces/todo_source.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

class TodoSource implements TodoSourceInterface {
  final _httpClient = injection.get<HttpClientInterface>();

  @override
  Future<Result<List<TodoModel>>> getTodos(int userId) async {
    try {
      final result = await _httpClient.get('/todos/user/$userId');

      if (result is ResultError) {
        return Result.error(result.error);
      }

      if (result is! Ok) {
        return Result.error(Exception('Resposta inválida da API de todos.'));
      }

      final data = result.value;
      if (data is! Map<String, dynamic> || data['todos'] is! List) {
        return Result.error(Exception('Formato inválido da API de todos.'));
      }

      final todos = (data['todos'] as List)
          .map(
            (item) =>
                TodoModel.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList();

      return Result.ok(todos);
    } catch (e) {
      return Result.error(
        Exception('Não foi possível obter os todos da API $e'),
      );
    }
  }
}
