part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginCallEvent extends LoginEvent {
  final LoginModel model;
  final bool isRememberMe;

  LoginCallEvent(this.model, this.isRememberMe);
}

class LoginShowPasswordEvent extends LoginEvent {}
