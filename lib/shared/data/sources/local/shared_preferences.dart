import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

final String sessionData = 'sessionData';

Future<void> saveSessionData(UserLoggedModel user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(sessionData, jsonEncode(user.toJson()));
}

Future<Result<UserLoggedModel>> getSessionData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final session = prefs.getString(sessionData);

    if (session == null) {
      return Result.error(Exception('Não existe uma sessão salva.'));
    }

    final json = jsonDecode(session) as Map<String, dynamic>;
    return Result.ok(UserLoggedModel.fromJson(json));
  } catch (error) {
    return Result.error(
      Exception('Não foi possível recuperar a sessão: $error'),
    );
  }
}

Future<void> removeSessionData() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove(sessionData);
}
