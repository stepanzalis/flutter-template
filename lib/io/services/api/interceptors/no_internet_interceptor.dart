import 'package:template/common/error/exceptions.dart';
import 'package:template/io/services/api/network_info_checker.dart';
import 'package:dio/dio.dart';

/// Intercepts the internet connection failures
class NoInternetInterceptor extends QueuedInterceptor {
  final NetworkInfo networkInfo;

  NoInternetInterceptor({required this.networkInfo});

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await networkInfo.isConnected) {
      handler.next(options);
    } else {
      handler.reject(
        DioError(
          error: NoInternetException(),
          requestOptions: options,
        ),
      );
    }
  }
}
