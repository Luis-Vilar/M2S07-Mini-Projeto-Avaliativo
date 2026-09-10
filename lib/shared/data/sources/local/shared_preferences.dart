import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/result_pattern.dart';

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
      return Result.error(Exception('No hay una sesión guardada.'));
    }

    final json = jsonDecode(session) as Map<String, dynamic>;
    return Result.ok(UserLoggedModel.fromJson(json));
  } catch (error) {
    return Result.error(Exception('No se pudo recuperar la sesión: $error'));
  }
}

Future<void> removeSessionData() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove(sessionData);
}
