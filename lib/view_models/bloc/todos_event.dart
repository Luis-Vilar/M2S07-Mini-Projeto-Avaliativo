part of 'todos_bloc.dart';

sealed class TodosEvent {}

final class TodosSyncEvent extends TodosEvent {
  TodosSyncEvent({required this.userId});

  int userId;
}

final class TodosCreateEvent extends TodosEvent {
  TodosCreateEvent({required this.todo});

  final TodoModel todo;
}

final class TodosReadEvent extends TodosEvent;

final class TodosUpdateEvent extends TodosEvent {
  TodosUpdateEvent({required this.todo});

  final TodoModel todo;
}

final class TodosDeleteEvent extends TodosEvent {
  TodosDeleteEvent({required this.id});

  final int id;
}
