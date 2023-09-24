part of 'cart_management_bloc.dart';

@immutable
abstract class CartManagementState {}

class CartManagementInitial extends CartManagementState {}

class CartFetchSuccessState extends CartManagementState {
  final List<CartListModel> model;

  CartFetchSuccessState({required this.model});
}

class CartListCachedState extends CartManagementState {
  final List<CartListModel> model;

  CartListCachedState({required this.model});
}

class CartListEmptyState extends CartManagementState {}

class CartAddSuccessState extends CartManagementState {}

class CartDeleteSuccessState extends CartManagementState {}

class CartErrorState extends CartManagementState {
  final String message;

  CartErrorState(this.message);
}

class CartExceptionState extends CartManagementState {
  final DioException exception;

  CartExceptionState(this.exception);
}
