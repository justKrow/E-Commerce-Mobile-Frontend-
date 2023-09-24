import '../../../config/api_constants/api_path.dart';
import '../../../config/api_constants/api_service.dart';

class CategoryRepo {
  final ApiService _service = ApiService();
  Future<String> fetchCategory() {
    Map<String, dynamic> requestBody = {};
    return _service.getData(ApiPath.fetchCategory, requestBody);
  }
}
