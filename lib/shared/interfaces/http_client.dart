import 'package:todo_app/shared/result_pattern.dart';

abstract class HttpClientInterfase {
  Future<Result> get(String endpoint, {Map<String, String>? headers});

  Future<Result> post(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  });
}
