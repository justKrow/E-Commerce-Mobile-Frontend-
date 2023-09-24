import 'package:dio/dio.dart';

import 'failure.dart';

class DioException implements Exception {
  late FailTure failture;
  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        failture = FailTure('Request to API server was cancelled');
        break;
      case DioErrorType.connectionTimeout:
        failture = FailTure('Connection timeout with API server');
        break;
      case DioErrorType.sendTimeout:
        failture = FailTure("Send timeout in connection with API server");
        break;
      case DioErrorType.receiveTimeout:
        failture = FailTure('Receive timeout in connection with API server');
        break;
      case DioErrorType.badResponse:
        failture = _handleError(dioError.response!);
        break;
      case DioErrorType.unknown:
        failture = FailTure('No internet connection');
        break;
      default:
        failture = FailTure('Unhandled DioErrorType: ${dioError.type}');
        break;
    }
  }

  FailTure _handleError(Response response) {
    final isAuthError =
        response.data?.toString().contains("Route [login] not defined");
    if (isAuthError == true) {
      return FailTure(
        "Authorization Error! Please login again",
        reason: FailureReason.authError,
      );
    } else {
      if (response.statusCode == 500) {
        return FailTure("Oops something went wrong!");
      } else {
        final msg = response.data!.toString();
        return FailTure(msg);
      }
    }
  }

  @override
  String toString() {
    return failture.message;
  }
}
