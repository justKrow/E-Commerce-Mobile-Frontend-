part of 'check_out_bloc.dart';

abstract class CheckOutState extends Equatable {
  const CheckOutState();

  @override
  List<Object> get props => [];
}

class CheckOutInitial extends CheckOutState {}

class CheckOutKpayState extends CheckOutState {}

class CheckOutWavePayState extends CheckOutState {}

class CheckOutCashOnDeliveryState extends CheckOutState {}

class CheckOutSuccessState extends CheckOutState {}

class CheckOutErrorState extends CheckOutState {}

class CheckOutExceptionState extends CheckOutState {}
