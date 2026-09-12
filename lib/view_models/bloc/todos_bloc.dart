import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/todo/todo_model.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/data/sources/local/shared_preferences.dart';
import 'package:todo_app/shared/interfaces/todo_repository.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitial()) {
    final repository = injection.get<TodoRepositoryInterface>();

    on<TodosSyncEvent>((event, emit) async {
      await _runWithLoading(emit, () async {
        final resultSessionData = await getSessionData();
        if (resultSessionData is ResultError) {
          final errorResult = resultSessionData as ResultError<UserLoggedModel>;
          throw errorResult.error;
        }

        if (resultSessionData is! Ok<UserLoggedModel>) {
          throw Exception('Não foi possível validar a sessão.');
        }

        final sessionUser = resultSessionData.value;
        final result = await repository.syncTodos(sessionUser.id);

        if (result is ResultError) {
          final errorResult = result as ResultError<List<TodoModel>>;
          throw errorResult.error;
        }
        if (result is Ok<List<TodoModel>>) {
          return result.value;
        }
        throw Exception('No se pudo sincronizar los todos.');
      });
    });

    on<TodosReadEvent>((event, emit) async {
      await _runWithLoading(emit, repository.getTodos);
    });

    on<TodosCreateEvent>((event, emit) async {
      await _runWithLoading(emit, () async {
        await repository.insertTodo(event.todo);
        return repository.getTodos();
      });
    });

    on<TodosUpdateEvent>((event, emit) async {
      await _runWithLoading(emit, () async {
        await repository.updateTodo(event.todo);
        return repository.getTodos();
      });
    });

    on<TodosDeleteEvent>((event, emit) async {
      await _runWithLoading(emit, () async {
        await repository.deleteTodo(event.id);
        return repository.getTodos();
      });
    });
  }

  Future<void> _runWithLoading(
    Emitter<TodosState> emit,
    Future<List<TodoModel>> Function() action,
  ) async {
    emit(TodosLoading());
    try {
      emit(TodosSuccess(todos: await action()));
    } catch (error) {
      emit(TodosError(message: error.toString()));
    }
  }
}
