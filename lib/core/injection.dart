import 'package:get_it/get_it.dart';
import 'package:todo_app/shared/implementations/dio_implementation.dart';
import 'package:todo_app/shared/interfases/http_client.dart';

final injection = GetIt.instance;

void initDependencyInjection() {
  injection.registerLazySingleton<HttpClientInterfase>(
    () => HttpClientDioImplementation(),
  );
}
