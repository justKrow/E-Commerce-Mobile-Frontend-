import 'package:dio/dio.dart';

import '../../../config/api_constants/api_path.dart';
import '../../../config/api_constants/api_service.dart';
import '../model/cart_model.dart';

class CartRepo {
  final ApiService _service = ApiService();
  Future<String> addCart(CartModel model) {
    FormData formData = FormData.fromMap(
      {
        "quantity": model.quantity,
        "product_id": model.product_id,
      },
    );
    return _service.postData(ApiPath.fetchCartUrl, formData);
  }

  Future<String> fetchCartList() {
    Map<String, dynamic> requestBody = {};
    return _service.getData(ApiPath.fetchCartUrl, requestBody);
  }

  Future<String> deleteCart(String query) {
    Map<String, dynamic> requestBody = {};
    return _service.deleteData(
        ApiPath.deleteCartUrl(query: query), requestBody);
  }
}
