import 'package:dio/dio.dart';
import 'package:todo_app/shared/interfaces/http_client.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

final class HttpClientDio implements HttpClientInterface {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: Duration(milliseconds: 5000),
    ),
  );

  @override
  Future<Result> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(headers: headers),
      );

      return Result.ok(response.data);
    } on DioException catch (error) {
      return Result.error(_toException(error));
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
      return Result.error(_toException(error));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Exception _toException(DioException error) {
    final message = switch (error.type) {
      DioExceptionType.connectionError =>
        'Sem internet?. Verifica a conexão e tenta novamente',
      DioExceptionType.connectionTimeout => 'Demorando para receber a resposta da API, verifique o sinal de internet',
      _ => 'Algo inesperado aconteceu, verifique suas credenciais e tenta novamente.',
    };

    return Exception(message);
  }
}
