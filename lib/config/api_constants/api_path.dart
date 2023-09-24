class ApiPath {
  static const String baseUrl = "https://myaitzimon.hapeyeapp.com/api";
  static const String fetchBanner = "$baseUrl/banner";
  static const String fetchCategory = "$baseUrl/category";
  static const String fetchProduct = "$baseUrl/product";
  static const String loginUrl = "$baseUrl/login";
  static const String registerUrl = "$baseUrl/register";
  static const String fetchNewProductUrl = "$baseUrl/product?keyword=new";
  static const String fetchSecondHandProductUrl =
      "$baseUrl/product?keyword=second";
  static String fetchMoreProductUrl({required int pageNumber, String? query}) =>
      "$baseUrl/product?keyword=$query&page=$pageNumber";
  static String searchQueryProductUrl({required String query}) =>
      "$baseUrl/product?keyword=$query";
  static const String fetchCartUrl = "$baseUrl/cart";
  static String deleteCartUrl({required String query}) =>
      "$baseUrl/cart/delete/$query";
}
