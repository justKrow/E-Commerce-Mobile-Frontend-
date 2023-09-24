import 'package:dio/dio.dart';
import 'package:###/local_storage/shared_pref.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<String> postAuthData(String url, FormData formData) async {
    try {
      _dio.options.headers['Accept'] = 'application/json';
      final resp = await _dio.request<dynamic>(
        url,
        data: formData,
        options: Options(method: "POST"),
      );

      return resp.toString();
    } on DioError {
      rethrow;
    }
  }

  Future<String> getData(String url, Map<String, dynamic> requestBody) async {
    String? token = await SharedPref.getStringValue(key: 'accessToken');
    try {
      _dio.options.headers['Accept'] = 'application/json';
      _dio.options.headers['Authorization'] = "Bearer $token";
      final resp = await _dio.request<dynamic>(
        url,
        queryParameters: requestBody,
        options: Options(method: "GET"),
      );
      return resp.toString();
    } on DioError {
      rethrow;
    }
  }

  Future<String> deleteData(
      String url, Map<String, dynamic> requestBody) async {
    String? token = await SharedPref.getStringValue(key: 'accessToken');
    try {
      _dio.options.headers['Accept'] = 'application/json';
      _dio.options.headers['Authorization'] = "Bearer $token";
      final resp = await _dio.request<dynamic>(
        url,
        queryParameters: requestBody,
        options: Options(method: "DELETE"),
      );
      return resp.toString();
    } on DioError {
      rethrow;
    }
  }

  Future<String> postData(String url, FormData formData) async {
    String? token = await SharedPref.getStringValue(key: 'accessToken');
    try {
      _dio.options.headers['Accept'] = 'application/json';
      _dio.options.headers['Authorization'] = "Bearer $token";
      final resp = await _dio.request<dynamic>(
        url,
        data: formData,
        options: Options(method: "POST"),
      );
      return resp.toString();
    } on DioError {
      rethrow;
    }
  }
}
