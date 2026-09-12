import 'package:get_it/get_it.dart';
import 'package:todo_app/shared/data/repositories/todos/todos_repository.dart';
import 'package:todo_app/shared/data/sources/external/auth_source.dart';
import 'package:todo_app/shared/data/sources/external/todo_source.dart';
import 'package:todo_app/shared/implementations/http_client_dio_implementation.dart';
import 'package:todo_app/shared/implementations/sqflite_crud_todo_implementation.dart';
import 'package:todo_app/shared/interfaces/auth.dart';
import 'package:todo_app/shared/interfaces/http_client.dart';
import 'package:todo_app/shared/interfaces/crud_todo.dart';
import 'package:todo_app/shared/interfaces/todo_repository.dart';
import 'package:todo_app/shared/interfaces/todo_source.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerLazySingleton<HttpClientInterface>(() => HttpClientDio());
  injection.registerLazySingleton<CrudTodoInterface>(() => SqfliteCrudTodo());
  injection.registerFactory<AuthInterface>(() => AuthSource());
  injection.registerFactory<TodoSourceInterface>(() => TodoSource());
  injection.registerFactory<TodoRepositoryInterface>(() => TodosRepository());
}
