part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final bool hasMorePage;
  final int currentPage;
  final List<ProductModel> products;

  SearchLoadedState(
      {required this.hasMorePage,
      required this.currentPage,
      required this.products});
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}

class SearchEmptyState extends SearchState {}

class SearchExceptionState extends SearchState {
  final DioException exception;

  SearchExceptionState(this.exception);
}
