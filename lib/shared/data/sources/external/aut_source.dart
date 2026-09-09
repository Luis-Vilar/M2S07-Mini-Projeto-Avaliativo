import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/interfases/auth.dart';
import 'package:todo_app/shared/interfases/http_client.dart';
import 'package:todo_app/shared/result_pattern.dart';

class AuthSource implements AuthInterfase {
  final _httpClient = injection.get<HttpClientInterfase>();
  @override
  Future<Result> login(UserLoginModel user) async {
    try {
      final result = await _httpClient.post(
        '/auth/login',
        body: {'username': user.username, 'password': user.password},
      );
      return result;
    } catch (e) {
      return Result.error(
        Exception('Não foi possível fazer login. Error : ${e.toString()}'),
      );
    }
  }
}
