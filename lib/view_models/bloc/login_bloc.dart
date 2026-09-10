import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/interfaces/auth.dart';
import 'package:todo_app/shared/result_pattern.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final auth = injection.get<AuthInterface>();

    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoading());
      final loginResult = await auth.login(event.user);

      if (loginResult is Ok) {
        //todo implementar shared_preferences
        // log(loginResult.value.toString());

        final userLoggedData = UserLoggedModel.fromJson(loginResult.value);

        log(userLoggedData.toString());
        emit(LoginSuccess());
      } else if (loginResult is ResultError) {
        //todo implementar snackbar informando erro
        final error = loginResult.error;
        if (error is DioException) {
          emit(
            LoginError(
              message:
                  error.response?.data?.toString() ?? error.message.toString(),
            ),
          );
        } else {
          emit(LoginError(message: error.toString()));
        }
      }
    });
  }
}
