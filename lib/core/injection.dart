import 'package:get_it/get_it.dart';
import 'package:todo_app/shared/data/sources/external/aut_source.dart';
import 'package:todo_app/shared/implementations/dio_implementation.dart';
import 'package:todo_app/shared/interfases/auth.dart';
import 'package:todo_app/shared/interfases/http_client.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerLazySingleton<HttpClientInterfase>(
    () => HttpClientDioImplementation(),
  );
  injection.registerFactory<AuthInterfase>(() => AuthSource());
}
