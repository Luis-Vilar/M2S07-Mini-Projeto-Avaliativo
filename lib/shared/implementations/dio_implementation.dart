import 'package:dio/dio.dart';
import 'package:todo_app/shared/interfases/http_client.dart';
import 'package:todo_app/shared/result_pattern.dart';

final class HttpClientDioImplementation implements HttpClientInterfase {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com/'));

  @override
  Future<Result> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(headers: headers),
      );

      return Result.ok(response.data);
    } on DioException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result> post(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );

      return Result.ok(response.data);
    } on DioException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
