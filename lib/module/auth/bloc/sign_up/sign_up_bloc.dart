import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:###/module/auth/bloc/sign_up/sign_up_event.dart';
import 'package:###/module/auth/bloc/sign_up/sign_up_state.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../../utils/dio_exception.dart';
import '../../repo/auth_repo.dart';

class SignupBloc extends Bloc<SignUpEvent, SignupState> {
  final AuthRepo repo;

  SignupBloc(this.repo) : super(SignupInitState()) {
    on<SignupCallEvent>(onSignupCallEvent);
  }

  Future<FutureOr<void>> onSignupCallEvent(
      SignupCallEvent event, Emitter<SignupState> emit) async {
    emit(SignupClickedState());
    try {
      var response = await repo.signUp(event.model);

      var restData = jsonDecode(response);
      if (restData['status'] == "success") {
        emit(SignupSussessState());
        var accessToken = restData["token"];
        var username = restData["data"]["name"];
        var email = restData["data"]["email"];
        var phone = restData["data"]["phone"];
        SharedPref.saveStringValue(key: 'accessToken', value: accessToken);
        SharedPref.saveStringValue(key: 'userName', value: username);
        SharedPref.saveStringValue(key: 'email', value: email);
        SharedPref.saveStringValue(key: 'phone', value: phone);
      } else {
        emit(SignupErrorState(restData['data'].toString()));
      }
    } on DioError catch (e) {
      emit(SignupExceptionState(DioException.fromDioError(e)));
    }
  }
}
