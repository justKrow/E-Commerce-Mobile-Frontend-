import 'package:equatable/equatable.dart';
import 'package:###/utils/dio_exception.dart';

class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitState extends SignupState {}

class SignupClickedState extends SignupState {}

class SignupSussessState extends SignupState {}

class SignupErrorState extends SignupState {
  final String message;

  SignupErrorState(this.message);
}

class SignupExceptionState extends SignupState {
  final DioException exception;

  SignupExceptionState(this.exception);
}
