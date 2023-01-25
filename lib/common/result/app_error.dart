import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';
import 'package:template/common/error/failures.dart';
import 'package:template/common/extensions/extensions.dart';

class AppError {
  AppError._({
    required this.failure,
    required this.message,
  });

  final String message;
  final Failure failure;

  factory AppError.fromException(Exception? exception) {
    if (exception is DioError) {
      logError(
        'AppError(DioError): '
        'type is ${exception.type}, message is ${exception.message}',
      );
      return AppError._(
        message: exception.message,
        failure: exception.failureFromDioError(),
      );
    } else {
      logError('AppError(Unknown): $exception');

      return AppError._(
        message: 'AppError: $exception',
        failure: Failure.unknown(exception),
      );
    }
  }

  @override
  String toString() => 'AppError(message: $message, failure: $failure)';
}
