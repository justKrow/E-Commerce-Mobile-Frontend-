import 'package:dio/dio.dart';

import '../../../config/api_constants/api_path.dart';
import '../../../config/api_constants/api_service.dart';
import '../model/login_model.dart';
import '../model/sign_up_model.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();

  Future<String> login(LoginModel model) {
    Map<String, dynamic> requestBody = {
      "phone": model.phone,
      "password": model.password,
    };
    FormData formData = FormData.fromMap(requestBody);
    return _apiService.postAuthData(ApiPath.loginUrl, formData);
  }

  Future<String> signUp(SignUpModel model) {
    Map<String, dynamic> requestBody = {
      "name": model.name,
      "email": model.email,
      "phone": model.phone,
      "password": model.password
    };
    FormData data = FormData.fromMap(requestBody);
    return _apiService.postAuthData(ApiPath.registerUrl, data);
  }
}
