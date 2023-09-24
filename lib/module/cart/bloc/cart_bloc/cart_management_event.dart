part of 'cart_management_bloc.dart';

@immutable
abstract class CartManagementEvent {}

class CartAddEvent extends CartManagementEvent {
  final CartModel model;

  CartAddEvent({required this.model});
}

class CartDeleteEvent extends CartManagementEvent {
  final String query;

  CartDeleteEvent({required this.query});
}

class CartListFetchEvent extends CartManagementEvent {}
