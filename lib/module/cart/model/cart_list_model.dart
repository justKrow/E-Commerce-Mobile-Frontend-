import 'package:###/module/home/model/product_model.dart';

class CartListModel {
  int? id;
  int? quantity;
  ProductModel? productModel;
  int? totalPrice;

  CartListModel({this.id, this.quantity, this.productModel, this.totalPrice});

  CartListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productModel =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    totalPrice = json['totalPrice'];
  }
}
