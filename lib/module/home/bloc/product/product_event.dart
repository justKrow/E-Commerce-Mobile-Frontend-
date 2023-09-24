part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {}

class FetchNewProductEvent extends ProductEvent {}

class FetchSeccondHandProductEvent extends ProductEvent {}

class FetchMoreProductEvent extends ProductEvent {
  final int pageNumber;
  final String? query;
  final List<ProductModel> products;

  FetchMoreProductEvent(
      {required this.pageNumber, this.query, required this.products});
}

class SearchProductEvent extends ProductEvent {
  final String? query;

  SearchProductEvent(this.query);
}
