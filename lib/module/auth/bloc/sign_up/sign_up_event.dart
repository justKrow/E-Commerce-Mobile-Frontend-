import 'package:equatable/equatable.dart';
import 'package:###/module/auth/model/sign_up_model.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupCallEvent extends SignUpEvent {
  final SignUpModel model;

  SignupCallEvent(this.model);
}
