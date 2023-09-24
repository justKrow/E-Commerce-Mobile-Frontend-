// ignore_for_file: non_constant_identifier_names

class ProductModel {
  int? id;
  String? name;
  int? price;
  int? stock;
  String? size;
  String? detail;
  String? category_name;
  String? brand_name;
  String? producttype_name;
  int? brand_id;
  List<String>? photos;

  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.stock,
      this.size,
      this.detail,
      this.category_name,
      this.brand_name,
      this.producttype_name,
      this.brand_id,
      this.photos});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    size = json['size'];
    detail = json['detail'];
    category_name = json['category_name'];
    brand_name = json['brand_name'];
    producttype_name = json['producttype_name'];
    brand_id = json['brand_id'];
    photos = List.castFrom<dynamic, String>(json['photos']);
  }
}
