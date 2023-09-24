part of 'banner_bloc.dart';

abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerFetchedState extends BannerState {
  final List<dynamic> imgUrls;

  BannerFetchedState({required this.imgUrls});
}

class BannerErrorState extends BannerState {}
