import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../utils/dio_exception.dart';
import '../../model/product_model.dart';
import '../../repo/product_fetch_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductFetchRepo repo;
  ProductBloc(this.repo) : super(ProductInitialState()) {
    on<FetchProductEvent>(onFetchProductEvent);
    on<FetchNewProductEvent>(onFetchNewProductEvent);
    on<FetchSeccondHandProductEvent>(onFetchSeccondHandProductEvent);
    on<FetchMoreProductEvent>(onFetchMoreProductEvent);
  }

  Future<FutureOr<void>> onFetchProductEvent(
      FetchProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitialState());
    List<ProductModel> products = [];

    try {
      var res = await repo.fetchProduct();
      var restData = jsonDecode(res);
      List<dynamic> data = restData['data'];
      bool hasMorePage = restData['meta']['has_more_page'];
      int currentPage = restData['meta']['current_page'];
      if (restData['status'] == 'success') {
        for (var item in data) {
          ProductModel product = ProductModel.fromJson(item);
          products.add(product);
        }
        emit(ProductFetchSuccessState(
            products: products,
            currentPage: currentPage,
            hasMorePage: hasMorePage));
      } else {
        emit(ProductErrorState(restData['data']));
      }
    } on DioError catch (e) {
      emit(ProductExceptionState(DioException.fromDioError(e)));
    }
  }

  Future<FutureOr<void>> onFetchNewProductEvent(
      FetchNewProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitialState());
    List<ProductModel> products = [];

    try {
      var res = await repo.fetchNewProduct();
      var restData = jsonDecode(res);
      if (restData['status'] == 'success') {
        List<dynamic> data = restData['data'];
        bool hasMorePage = restData['meta']['has_more_page'];
        int currentPage = restData['meta']['current_page'];
        for (var item in data) {
          ProductModel product = ProductModel.fromJson(item);
          products.add(product);
        }
        emit(ProductFetchSuccessState(
            products: products,
            currentPage: currentPage,
            hasMorePage: hasMorePage));
      } else {
        emit(ProductErrorState(restData['data']));
      }
    } on DioError catch (e) {
      emit(ProductExceptionState(DioException.fromDioError(e)));
    }
  }

  Future<FutureOr<void>> onFetchSeccondHandProductEvent(
      FetchSeccondHandProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitialState());
    List<ProductModel> products = [];

    try {
      var res = await repo.fetchSecondHandProduct();
      var restData = jsonDecode(res);
      List<dynamic> data = restData['data'];
      bool hasMorePage = restData['meta']['has_more_page'];
      int currentPage = restData['meta']['current_page'];
      if (restData['status'] == 'success') {
        for (var item in data) {
          ProductModel product = ProductModel.fromJson(item);
          products.add(product);
        }
        emit(ProductFetchSuccessState(
            products: products,
            currentPage: currentPage,
            hasMorePage: hasMorePage));
      } else {
        emit(ProductErrorState(restData['data']));
      }
    } on DioError catch (e) {
      emit(ProductExceptionState(DioException.fromDioError(e)));
    }
  }

  Future<FutureOr<void>> onFetchMoreProductEvent(
      FetchMoreProductEvent event, Emitter<ProductState> emit) async {
    List<ProductModel> products = event.products;
    try {
      var res = await repo.fetchMoreProuct(
          pageNumber: event.pageNumber, query: event.query);
      var restData = jsonDecode(res);

      List<dynamic> data = restData['data'];
      bool hasMorePage = restData['meta']['has_more_page'];
      int currentPage = restData['meta']['current_page'];
      if (restData['status'] == 'success' && data.isEmpty) {
        emit(ProductFetchEmptyState());
      } else if (restData['status'] == 'success' && data.isNotEmpty) {
        for (var item in data) {
          ProductModel product = ProductModel.fromJson(item);
          products.add(product);
        }
        emit(ProductFetchSuccessState(
            products: products,
            currentPage: currentPage,
            hasMorePage: hasMorePage));
      } else {
        emit(ProductErrorState(restData['data']));
      }
    } on DioError catch (e) {
      emit(ProductExceptionState(DioException.fromDioError(e)));
    }
  }
}
