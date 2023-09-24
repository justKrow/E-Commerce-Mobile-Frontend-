import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import '../../repo/banner_fetch_repo.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerFetchRepo repo;
  BannerBloc(this.repo) : super(BannerInitialState()) {
    on<BannerFetchEvent>(onBannerFetchEvent);
  }

  Future<FutureOr<void>> onBannerFetchEvent(
      BannerFetchEvent event, Emitter<BannerState> emit) async {
    emit(BannerInitialState());
    try {
      var res = await repo.fetchBanner();
      var data = jsonDecode(res);
      List<dynamic> imageUrls = data["data"];
      if (imageUrls.isNotEmpty) {
        emit(BannerFetchedState(imgUrls: imageUrls));
      } else {
        emit(BannerErrorState());
      }
    } catch (e) {
      emit(BannerErrorState());
    }
  }
}
