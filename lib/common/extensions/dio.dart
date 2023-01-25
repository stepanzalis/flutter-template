import 'package:template/common/error/exceptions.dart';
import 'package:dio/dio.dart';

extension DioErrorExtension on DioError {
  bool get isResponseError {
    return type == DioErrorType.response;
  }

  bool get isTimeout {
    return type == DioErrorType.connectTimeout || type == DioErrorType.receiveTimeout;
  }

  bool get isNoInternetError => error is NoInternetException;
}
