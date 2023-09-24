part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductFetchSuccessState extends ProductState {
  final List<ProductModel> products;
  final bool hasMorePage;
  final int currentPage;

  ProductFetchSuccessState(
      {required this.hasMorePage,
      required this.currentPage,
      required this.products});
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState(this.message);
}

class LatestProductState extends ProductState {}

class NewProductState extends ProductState {}

class SecondHandProductState extends ProductState {}

class ProductFetchEmptyState extends ProductState {}

class ProductExceptionState extends ProductState {
  final DioException exception;

  ProductExceptionState(this.exception);
}
