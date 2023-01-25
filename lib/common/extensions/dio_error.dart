import 'package:template/common/error/exceptions.dart';
import 'package:template/common/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';
import '../error/failures.dart';

extension DioErrorExt on DioError {
  Failure failureFromDioError() {
    logError("HTTP error: ${toString()}");

    if (error is NoInternetException) {
      return const Failure.noInternetConnection();
    }
    if (type == DioErrorType.connectTimeout || type == DioErrorType.receiveTimeout) {
      return const Failure.timeout();
    }
    if (isResponseError) {
      try {
        final int? statusCode = response?.statusCode;
        final error = ServerResponseError.fromJson(response?.data);
        return Failure.serverError(
          error.code,
          error.message,
          statusCode,
        );
      } catch (e) {
        return Failure.serverError(
          "http error",
          response?.statusMessage,
          response?.statusCode,
        );
      }
    } else {
      return const Failure.unknown();
    }
  }
}
