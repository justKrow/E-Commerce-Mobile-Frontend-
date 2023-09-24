import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../local_storage/shared_pref.dart';
import '../model/payment_model.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc() : super(CheckOutInitial()) {
    on<KpayEvent>(onKpayEvent);
    on<WavePayEvent>(onWavePayEvent);
    on<CashOnDeliveryEvent>(onCashOnDeliveryEvent);
    on<CheckOutConfirmEvent>(onCheckOutConfirmEvent);
  }

  FutureOr<void> onKpayEvent(KpayEvent event, Emitter<CheckOutState> emit) {
    emit(CheckOutKpayState());
  }

  FutureOr<void> onWavePayEvent(
      WavePayEvent event, Emitter<CheckOutState> emit) {
    emit(CheckOutWavePayState());
  }

  FutureOr<void> onCashOnDeliveryEvent(
      CashOnDeliveryEvent event, Emitter<CheckOutState> emit) {
    emit(CheckOutCashOnDeliveryState());
  }

  FutureOr<void> onCheckOutConfirmEvent(
      CheckOutConfirmEvent event, Emitter<CheckOutState> emit) {
    bool isRememberAddress = event.model.isRememberAddress;
    if (isRememberAddress) {
      SharedPref.saveStringValue(key: "state", value: event.model.state);
      SharedPref.saveStringValue(key: "city", value: event.model.city);
      SharedPref.saveStringValue(key: "address", value: event.model.address);
    } else {
      SharedPref.saveStringValue(key: "state", value: "");
      SharedPref.saveStringValue(key: "city", value: "");
      SharedPref.saveStringValue(key: "address", value: "");
    }
    emit(CheckOutSuccessState());
  }
}
