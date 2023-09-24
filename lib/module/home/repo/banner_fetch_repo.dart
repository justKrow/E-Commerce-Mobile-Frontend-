import '../../../config/api_constants/api_path.dart';
import '../../../config/api_constants/api_service.dart';

class BannerFetchRepo {
  final ApiService _service = ApiService();
  Future<String> fetchBanner() {
    Map<String, dynamic> requestBody = {};
    return _service.getData(ApiPath.fetchBanner, requestBody);
  }
}
