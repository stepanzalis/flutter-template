import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:template/io/model/cached_response.dart';
import 'package:template/io/services/local/storage/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

const dioCacheForceRefreshKey = 'dio_cache_force_refresh_key';

/// Interceptor for caching control
class CacheInterceptor implements QueuedInterceptor {
  final StorageService storageService;

  CacheInterceptor(this.storageService);

  @visibleForTesting
  String createStorageKey(
    String method,
    String baseUrl,
    String path, [
    Map<String, dynamic> queryParameters = const {},
  ]) {
    String storageKey = '${method.toUpperCase()}:${baseUrl + path}/';
    if (queryParameters.isNotEmpty) {
      storageKey += '?';
      queryParameters.forEach((key, value) {
        storageKey += '$key=$value&';
      });
    }
    return storageKey;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logError('❌ Dio Error!');
    logError('Url: ${err.requestOptions.uri}');
    logError('${err.stackTrace}');
    logError('Response Errors: ${err.response?.data}');
    String storageKey = createStorageKey(
      err.requestOptions.method,
      err.requestOptions.baseUrl,
      err.requestOptions.path,
      err.requestOptions.queryParameters,
    );
    if (storageService.has(storageKey)) {
      final CachedResponse? cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        logDebug('📦 Retrieved response from cache');
        final Response response = cachedResponse.buildResponse(err.requestOptions);
        logDebug('⬅️  Response');
        logDebug(
            '<---- ${response.statusCode != 200 ? '❌ ${response.statusCode}' : '✅ 200'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        logDebug('Query params: ${response.requestOptions.queryParameters}');
        logDebug('-------------------------');
        return handler.resolve(response);
      }
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra[dioCacheForceRefreshKey] == true) {
      logDebug('🌍 🌍 🌍 Retrieving request from network by force refresh');
      return handler.next(options);
    }
    String storageKey = createStorageKey(
      options.method,
      options.baseUrl,
      options.path,
      options.queryParameters,
    );
    if (storageService.has(storageKey)) {
      final CachedResponse? cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        logDebug('📦 Retrieved response from cache');
        final Response response = cachedResponse.buildResponse(options);
        logDebug('⬅️ Response');
        logDebug(
            '<---- ${response.statusCode != 200 ? '❌ ${response.statusCode}' : '✅ 200'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        logDebug('Query params: ${response.requestOptions.queryParameters}');
        logDebug('-------------------------');
        return handler.resolve(response);
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String storageKey = createStorageKey(
      response.requestOptions.method,
      response.requestOptions.baseUrl,
      response.requestOptions.path,
      response.requestOptions.queryParameters,
    );

    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      logDebug('🌍Retrieved response from network');
      logDebug('⬅️ Response');
      logDebug(
          '<---- ${response.statusCode != 200 ? '❌ ${response.statusCode}' : '✅ 200'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      logDebug('Query params: ${response.requestOptions.queryParameters}');
      logDebug('-------------------------');

      CachedResponse cachedResponse = CachedResponse(
        data: response.data,
        headers: Headers.fromMap(response.headers.map),
        age: DateTime.now(),
        statusCode: response.statusCode!,
      );
      storageService.set(storageKey, cachedResponse.toJson());
    }
    return handler.next(response);
  }

  CachedResponse? _getCachedResponse(String storageKey) {
    final rawCachedResponse = storageService.get(storageKey);
    try {
      final CachedResponse cachedResponse = CachedResponse.fromJson(
        json.decode(json.encode(rawCachedResponse)),
      );
      if (cachedResponse.isValid) {
        return cachedResponse;
      } else {
        logDebug('Cache is outdated, deleting it...');
        storageService.remove(storageKey);
        return null;
      }
    } catch (e) {
      logDebug('Error retrieving response from cache');
      logDebug('e: $e');
      return null;
    }
  }
}
