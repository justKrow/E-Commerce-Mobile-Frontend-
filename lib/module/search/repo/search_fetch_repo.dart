import '../../../config/api_constants/api_path.dart';
import '../../../config/api_constants/api_service.dart';

class SearchRepo {
  final ApiService _service = ApiService();
  Future<String> fetchQuery(String query) {
    Map<String, dynamic> requestBody = {};
    return _service.getData(
        ApiPath.searchQueryProductUrl(query: query), requestBody);
  }

  Future<String> fetchMoreProuct({required int pageNumber, String? query}) {
    Map<String, dynamic> requestBody = {};
    return _service.getData(
        ApiPath.fetchMoreProductUrl(pageNumber: pageNumber, query: query ?? ""),
        requestBody);
  }
}
