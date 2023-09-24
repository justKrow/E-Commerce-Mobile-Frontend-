import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../utils/dio_exception.dart';
import '../../../home/model/product_model.dart';
import '../../repo/search_fetch_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo repo;
  SearchBloc(this.repo) : super(SearchInitialState()) {
    on<SearchCallEvent>(onSearchCallEvent);
    on<SearchMoreProductEvent>(onSearchMoreProductEvent);
  }

  Future<FutureOr<void>> onSearchCallEvent(
      SearchCallEvent event, Emitter<SearchState> emit) async {
    List<ProductModel> products = [];
    emit(SearchLoadingState());
    var res = await repo.fetchQuery(event.query);
    try {
      var restData = jsonDecode(res);
      List<dynamic> data = restData['data'];
      bool hasMorePage = restData['meta']['has_more_page'];
      int currentPage = restData['meta']['current_page'];
      if (data.isEmpty) {
        emit(SearchEmptyState());
      } else {
        for (var item in data) {
          ProductModel product = ProductModel.fromJson(item);
          products.add(product);
        }
        emit(SearchLoadedState(
            products: products,
            currentPage: currentPage,
            hasMorePage: hasMorePage));
      }
    } on DioError catch (e) {
      emit(SearchExceptionState(DioException.fromDioError(e)));
    }
  }

  Future<FutureOr<void>> onSearchMoreProductEvent(
      SearchMoreProductEvent event, Emitter<SearchState> emit) async {
    List<ProductModel> products = event.products;
    try {
      var res = await repo.fetchMoreProuct(
          pageNumber: event.pageNumber, query: event.query);
      var restData = jsonDecode(res);

      List<dynamic> data = restData['data'];
      bool hasMorePage = restData['meta']['has_more_page'];
      int currentPage = restData['meta']['current_page'];
      if (restData['status'] == 'success' && data.isEmpty) {
        emit(SearchEmptyState());
      } else if (restData['status'] == 'success' && data.isNotEmpty) {
        for (var item in data) {
          ProductModel product = ProductModel.fromJson(item);
          products.add(product);
        }
        emit(SearchLoadedState(
            products: products,
            currentPage: currentPage,
            hasMorePage: hasMorePage));
      } else {
        emit(SearchErrorState(data.toString()));
      }
    } on DioError catch (e) {
      emit(SearchExceptionState(DioException.fromDioError(e)));
    }
  }
}
