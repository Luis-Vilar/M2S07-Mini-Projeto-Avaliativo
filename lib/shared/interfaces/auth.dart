import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

abstract class AuthInterface {
  Future<Result> login(UserLoginModel user);
}
