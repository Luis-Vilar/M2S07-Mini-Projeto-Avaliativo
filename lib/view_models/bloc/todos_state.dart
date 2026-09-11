part of 'todos_bloc.dart';

sealed class TodosState {}

final class TodosInitial extends TodosState {}

final class TodosLoading extends TodosState {}

final class TodosSuccess extends TodosState {
	TodosSuccess({required this.todos});

	final List<TodoModel> todos;
}

final class TodosError extends TodosState {
	TodosError({required this.message});

	final String message;
}
