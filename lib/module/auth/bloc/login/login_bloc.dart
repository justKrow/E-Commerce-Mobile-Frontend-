import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../../utils/dio_exception.dart';
import '../../model/login_model.dart';
import '../../repo/auth_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo repo;
  LoginBloc(this.repo) : super(LoginInitialState()) {
    on<LoginCallEvent>(onLoginCallEvent);
  }

  Future<FutureOr<void>> onLoginCallEvent(
      LoginCallEvent event, Emitter<LoginState> emit) async {
    emit(LoginClickedState());
    String phone = event.model.phone;
    String password = event.model.password;
    bool isRememberMe = event.isRememberMe;
    if (isRememberMe) {
      SharedPref.saveBoolValue(key: "isRememberMe", value: isRememberMe);
      SharedPref.saveStringValue(key: "password", value: password);
      SharedPref.saveStringValue(key: "phone", value: phone);
    } else {
      SharedPref.saveBoolValue(key: "isRememberMe", value: isRememberMe);
      SharedPref.saveStringValue(key: "password", value: "");
      SharedPref.saveStringValue(key: "phone", value: "");
    }

    try {
      var res = await repo.login(event.model);
      var restData = jsonDecode(res);
      if (restData['status'] == "success") {
        emit(LoginSuccessState());
        var userName = restData["user"]["name"];
        var accessToken = restData["token"];
        var phoneNumber = restData["user"]["phone"];

        SharedPref.saveStringValue(key: 'accessToken', value: accessToken);
        SharedPref.saveStringValue(key: "userName", value: userName);
        SharedPref.saveStringValue(key: "phone", value: phoneNumber);
      } else {
        emit(LoginErrorState(restData['data']));
      }
    } on DioError catch (e) {
      emit(LoginExceptionState(DioException.fromDioError(e)));
    }
  }
}
