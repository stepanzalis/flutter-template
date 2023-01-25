import 'package:template/common/constants/constants.dart';
import 'package:template/io/services/local/storage/storage_service.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends QueuedInterceptor {
  final StorageService _localDataSource;

  TokenInterceptor({
    required StorageService localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _checkToken(options);
    handler.next(options);
  }

  Future<void> _checkToken(RequestOptions options) async {
    final token = _localDataSource.get<String>(HiveConstants.token);
    options.headers[ApiConstants.authorizationHeader] = token;
  }
}
