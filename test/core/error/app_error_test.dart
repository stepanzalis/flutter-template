import 'dart:io';
import 'package:template/common/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/common/result/app_error.dart';
import 'package:template/common/error/exceptions.dart';

void main() {
  group('Dio errors', () {
    test(
      'Throw [Failure.noInternetConnection()] if network error occurred',
      () {
        expect(
          AppError.fromException(
            DioError(
              error: NoInternetException(),
              type: DioErrorType.other,
              requestOptions: RequestOptions(path: ''),
            ),
          ).failure,
          equals(Failure.noInternetConnection()),
        );
      },
    );

    test(
      'Throw [Failure.serverError()] if HTTP is not success response code',
      () {
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        );

        expect(
          AppError.fromException(
            DioError(
              type: DioErrorType.response,
              requestOptions: RequestOptions(path: ''),
              response: response,
            ),
          ).failure,
          equals(
            Failure.serverError("http error", response.statusMessage, 404),
          ),
        );
      },
    );

    test(
      'Throw [Failure.serverError()] with null data because of parsing error',
      () {
        final response = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {},
        );

        expect(
          AppError.fromException(
            DioError(
              type: DioErrorType.response,
              requestOptions: RequestOptions(path: ''),
              response: Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 401,
                data: {},
              ),
            ),
          ).failure,
          equals(Failure.serverError(
            "http error",
            response.statusMessage,
            401,
          )),
        );
      },
    );

    test(
      'Throw [Failure.timeout()] if request timeouts',
      () {
        expect(
          AppError.fromException(
            DioError(
              type: DioErrorType.connectTimeout,
              requestOptions: RequestOptions(path: ''),
            ),
          ).failure,
          equals(Failure.timeout()),
        );
      },
    );

    test(
      'Throw [Failure.timeout()] if response timeouts',
      () {
        expect(
          AppError.fromException(
            DioError(
              type: DioErrorType.receiveTimeout,
              requestOptions: RequestOptions(path: ''),
            ),
          ).failure,
          equals(Failure.timeout()),
        );
      },
    );
  });

  group(
    'Unknown error tests',
    () {
      test('Throw [Failure.unknown()] error while passed a system exception', () {
        expect(
          AppError.fromException(const FileSystemException()).failure,
          equals(Failure.unknown(const FileSystemException())),
        );
      });
      test('Throw [Failure.unknown()] when passed null as exception', () {
        expect(AppError.fromException(null).failure, equals(Failure.unknown()));
      });
    },
  );
}
