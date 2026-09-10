import 'package:get_it/get_it.dart';
import 'package:todo_app/shared/data/sources/external/auth_source.dart';
import 'package:todo_app/shared/implementations/dio_implementation.dart';
import 'package:todo_app/shared/implementations/todo_repository_sqflite_implementation.dart';
import 'package:todo_app/shared/interfaces/auth.dart';
import 'package:todo_app/shared/interfaces/http_client.dart';
import 'package:todo_app/shared/interfaces/todo_repository.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerLazySingleton<HttpClientInterface>(
    () => HttpClientDioImplementation(),
  );
  injection.registerFactory<AuthInterface>(() => AuthSource());
  injection.registerLazySingleton<TodoRepositoryInterface>(
    () => SqfliteTodoRepository(),
  );
}
