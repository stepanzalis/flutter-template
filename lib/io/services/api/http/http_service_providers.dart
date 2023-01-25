import 'package:device_info_plus/device_info_plus.dart';
import 'package:template/common/constants/constants.dart';
import 'package:template/common/env/env_config.dart';
import 'package:template/io/services/api/http/dio_http_service.dart';
import 'package:template/io/services/api/interceptors/interceptors.dart';
import 'package:template/io/services/local/storage/hive_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final logInterceptor = Provider<PrettyDioLogger>(
  (ref) {
    const canPrint = EnvConfig.isTestEnvironment;

    final logInterceptor = PrettyDioLogger(
      request: canPrint,
      requestBody: canPrint,
      responseBody: canPrint,
      error: canPrint,
      responseHeader: false,
      requestHeader: false,
    );

    return logInterceptor;
  },
);

/// Connection internet checker
final networkInfoProvider = Provider(
  (ref) {
    final networkConnectionChecker = InternetConnectionChecker();
    final networkInfo = NetworkInfoImpl(networkConnectionChecker);
    return networkInfo;
  },
);

/// Connection internet interceptor
final noInternetProvider = Provider<NoInternetInterceptor>((ref) {
  final noInternetChecker = ref.read(networkInfoProvider);
  return NoInternetInterceptor(networkInfo: noInternetChecker);
});

/// Device info provider
final userAgentProvider = Provider<UserAgentInterceptor>((ref) {
  final deviceInfo = DeviceInfoPlugin();
  return UserAgentInterceptor(deviceInfo: deviceInfo);
});

/// Token interceptor provider
final tokenInterceptorProvider = Provider((ref) {
  final appPreferences = ref.read(storageServiceProvider);
  return TokenInterceptor(localDataSource: appPreferences);
});

/// Base URL
final baseUrlProvider = Provider<String>((ref) {
  return EnvConfig.isTestEnvironment ? ApiConstants.baseStageUrl : ApiConstants.baseProdUrl;
});

/// HTTP custom client
final httpServiceProvider = Provider.autoDispose.family<DioHttpService, bool>((
  ref,
  provideHttpCache,
) {
  final storageService = ref.watch(storageServiceProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  final noInternetInterceptor = ref.watch(noInternetProvider);
  final userAgentInterceptor = ref.watch(userAgentProvider);
  final tokenInterceptor = ref.watch(tokenInterceptorProvider);
  final loggingInterceptor = ref.watch(logInterceptor);

  return DioHttpService(
    storageService,
    baseUrl,
    enableCaching: provideHttpCache,
    appInterceptors: [
      noInternetInterceptor,
      userAgentInterceptor,
      tokenInterceptor,
      loggingInterceptor,
    ],
  );
});
