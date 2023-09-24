import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:###/module/cart/repo/cart_repo.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../../utils/dio_exception.dart';
import '../../../home/model/product_model.dart';
import '../../model/cart_list_model.dart';
import '../../model/cart_model.dart';
import '../../screens/cart_page.dart';

part 'cart_management_event.dart';
part 'cart_management_state.dart';

class CartManagementBloc
    extends Bloc<CartManagementEvent, CartManagementState> {
  final CartRepo repo;

  CartManagementBloc(this.repo) : super(CartManagementInitial()) {
    on<CartListFetchEvent>(onCartListFetchEvent);
    on<CartAddEvent>(onCartAddEvent);
    on<CartDeleteEvent>(onCartDeleteEvent);
  }

  Future<FutureOr<void>> onCartListFetchEvent(
      CartListFetchEvent event, Emitter<CartManagementState> emit) async {
    String? res = await SharedPref.getStringValue(key: 'cartList');

    List<CartListModel> carts = [];
    List<CartListModel> cachedCarts = [];
    if (res != null) {
      try {
        var restData = jsonDecode(res);
        List<dynamic> data = restData['data'];

        totalPrice = restData['totalPrice'];
        if (restData["status"] == "success" && data.isNotEmpty) {
          for (var item in data) {
            CartListModel cart = CartListModel.fromJson(item);
            var productData = item['product'];
            ProductModel product = ProductModel.fromJson(productData);
            cart.productModel = product;
            cachedCarts.add(cart);
          }

          emit(CartListCachedState(model: cachedCarts));
        } else if (restData["status"] == "success" && data.isEmpty) {
          emit(CartListEmptyState());
        } else {
          emit(CartErrorState(data.toString()));
        }
      } on DioError catch (e) {
        emit(CartExceptionState(DioException.fromDioError(e)));
      }
    }
    try {
      var res = await repo.fetchCartList();
      SharedPref.saveStringValue(key: 'cartList', value: res);
      var restData = jsonDecode(res);
      List<dynamic> data = restData['data'];
      totalPrice = restData['totalPrice'];

      if (restData["status"] == "success" && data.isNotEmpty) {
        for (var item in data) {
          CartListModel cart = CartListModel.fromJson(item);
          var productData = item['product'];
          ProductModel product = ProductModel.fromJson(productData);
          cart.productModel = product;
          carts.add(cart);
        }
        emit(CartFetchSuccessState(model: carts));
      } else if (restData["status"] == "success" && data.isEmpty) {
        emit(CartListEmptyState());
      } else {
        emit(CartErrorState(data.toString()));
      }
    } on DioError catch (e) {
      emit(CartExceptionState(DioException.fromDioError(e)));
    }
  }

  Future<FutureOr<void>> onCartAddEvent(
      CartAddEvent event, Emitter<CartManagementState> emit) async {
    try {
      var res = await repo.addCart(event.model);
      var restData = jsonDecode(res);
      if (restData['status'] == 'success') {
        emit(CartAddSuccessState());
      } else {
        emit(CartErrorState(restData['data']));
      }
    } on DioError catch (e) {
      emit(CartExceptionState(DioException.fromDioError(e)));
    }
  }

  Future<FutureOr<void>> onCartDeleteEvent(
      CartDeleteEvent event, Emitter<CartManagementState> emit) async {
    await repo.deleteCart(event.query);
  }
}
