class CategoryModel {
  int? id;
  String? name;
  String? photo;
  List<Brands>? brands;

  CategoryModel({this.id, this.name, this.photo, this.brands});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
  }
}

class Brands {
  int? id;
  String? name;
  String? photo;

  Brands({this.id, this.name, this.photo});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }
}
