part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginClickedState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}

class LoginExceptionState extends LoginState {
  final DioException exception;

  LoginExceptionState(this.exception);
}

class LoginEmptyState extends LoginState {}
