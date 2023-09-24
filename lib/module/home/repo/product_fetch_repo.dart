import '../../../config/api_constants/api_path.dart';
import '../../../config/api_constants/api_service.dart';

class ProductFetchRepo {
  final ApiService _service = ApiService();
  Future<String> fetchProduct() {
    Map<String, dynamic> requestBody = {};
    return _service.getData(ApiPath.fetchProduct, requestBody);
  }

  Future<String> fetchNewProduct() {
    Map<String, dynamic> requestBody = {};
    return _service.getData(ApiPath.fetchNewProductUrl, requestBody);
  }

  Future<String> fetchSecondHandProduct() {
    Map<String, dynamic> requestBody = {};
    return _service.getData(ApiPath.fetchSecondHandProductUrl, requestBody);
  }

  Future<String> fetchMoreProuct({required int pageNumber, String? query}) {
    Map<String, dynamic> requestBody = {};
    return _service.getData(
        ApiPath.fetchMoreProductUrl(pageNumber: pageNumber, query: query ?? ""),
        requestBody);
  }

  Future<String> fetchQuery(String query) {
    Map<String, dynamic> requestBody = {};
    return _service.getData(
        ApiPath.searchQueryProductUrl(query: query), requestBody);
  }
}
