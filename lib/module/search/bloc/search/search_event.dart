part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchCallEvent extends SearchEvent {
  final String query;

  SearchCallEvent(this.query);
}

class SearchMoreProductEvent extends SearchEvent {
  final int pageNumber;
  final String? query;
  final List<ProductModel> products;

  SearchMoreProductEvent(
      {required this.pageNumber, this.query, required this.products});
}
