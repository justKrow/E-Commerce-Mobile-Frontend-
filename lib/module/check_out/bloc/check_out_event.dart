part of 'check_out_bloc.dart';

abstract class CheckOutEvent extends Equatable {
  const CheckOutEvent();

  @override
  List<Object> get props => [];
}

class KpayEvent extends CheckOutEvent {}

class WavePayEvent extends CheckOutEvent {}

class CashOnDeliveryEvent extends CheckOutEvent {}

class CheckOutConfirmEvent extends CheckOutEvent {
  final PaymentModel model;

  const CheckOutConfirmEvent(this.model);
}
