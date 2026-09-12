import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/injection.dart';
import 'package:todo_app/shared/data/models/user/user_model.dart';
import 'package:todo_app/shared/data/sources/local/shared_preferences.dart';
import 'package:todo_app/shared/interfaces/auth.dart';
import 'package:todo_app/shared/utils/result_pattern.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final auth = injection.get<AuthInterface>();

    on<CheckSessionEvent>((event, emit) async {
      emit(LoginLoading());

      final sessionResult = await getSessionData();
      if (sessionResult is Ok<UserLoggedModel>) {
        log(sessionResult.value.toString());
        emit(LoginSuccess(userLoggedModel: sessionResult.value));
      } else {
        emit(LoginInitial());
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoading());

      final sessionResult = await getSessionData();
      if (sessionResult is Ok<UserLoggedModel>) {
        log(sessionResult.value.toString());
        emit(LoginSuccess(userLoggedModel: sessionResult.value));
        return;
      }

      final loginResult = await auth.login(event.user);

      if (loginResult is Ok) {
        final userLoggedData = UserLoggedModel.fromJson(loginResult.value);

        await saveSessionData(userLoggedData);
        log(userLoggedData.toString());
        emit(LoginSuccess(userLoggedModel: userLoggedData));
      } else if (loginResult is ResultError) {
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
