// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent {}

class CheckSessionEvent extends LoginEvent {}

class LoginUserEvent extends LoginEvent {
  UserLoginModel user;
  LoginUserEvent({required this.user});
}
