import 'package:template/common/constants/constants.dart';
import 'package:template/common/error/exceptions.dart';
import 'package:template/common/extensions/extensions.dart';
import 'package:template/io/services/api/interceptors/cache_interceptor.dart';
import 'package:template/io/services/local/storage/storage_service.dart';
import 'package:dio/dio.dart';

import 'http_service.dart';

/// Custom [Dio] HTTP service with option to get cached result when
/// [enableCaching] is enabled
class DioHttpService implements HttpService {
  late final Dio _dio;
  late final String _apiBaseUrl;

  DioHttpService(
    StorageService storageService,
    String apiBaseUrl, {
    List<Interceptor> appInterceptors = const [],
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    _apiBaseUrl = apiBaseUrl;
    _dio = dioOverride ?? Dio(baseOptions);

    _dio.interceptors
      ..add(enableCaching ? CacheInterceptor(storageService) : Interceptor())
      ..addAll(appInterceptors);
  }

  @override
  String get baseUrl => _validHttpUrl(_apiBaseUrl) ? _apiBaseUrl : throw InvalidBaseUrlException(_apiBaseUrl);

  @override
  Map<String, String> headers = {'accept': 'application/json', 'content-type': 'application/json'};

  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: ApiConstants.timeoutInMs,
        receiveTimeout: ApiConstants.timeoutInMs,
      );

  @override
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool forceRefresh = false,
    String? customBaseUrl,
  }) async {
    _dio.options.extra[dioCacheForceRefreshKey] = forceRefresh;

    Response response = await _dio.get(
      endpoint,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
    _throwIfInvalidHttpResponse(response);
    return response.data;
  }

  @override
  Future<T> post<T>(
    String endpoint, {
    dynamic data,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await _dio.post(
      endpoint,
      data: data,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );

    _throwIfInvalidHttpResponse(response);
    return response.data;
  }

  @override
  Future<T> delete<T>(
    String endpoint, {
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    Response response = await _dio.delete(
      endpoint,
      data: data,
      cancelToken: cancelToken,
    );
    _throwIfInvalidHttpResponse(response);
    return response.data;
  }

  @override
  Future<T> put<T>(
    String endpoint, {
    dynamic data,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await _dio.put(
      endpoint,
      data: data,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
    _throwIfInvalidHttpResponse(response);
    return response.data;
  }

  @override
  Future<T> patch<T>(
    String endpoint, {
    dynamic data,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await _dio.patch(
      endpoint,
      data: data,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
    _throwIfInvalidHttpResponse(response);
    return response.data;
  }
}

bool _validHttpUrl(String apiBaseUrl) => Uri.parse(apiBaseUrl).host.isNotEmpty;

/// Check if given response is successful from status code
///
/// Throws [HttpException] if status code is not in range from 200 to 299
Response _throwIfInvalidHttpResponse(Response response) {
  List<int> validHttpRange = 200.rangeTo(299);

  if (response.data == null || !validHttpRange.contains(response.statusCode)) {
    throw HttpException(
      title: 'Http Error!',
      statusCode: response.statusCode,
      message: response.statusMessage,
    );
  }

  return response;
}
