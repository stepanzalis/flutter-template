class ApiConstants {
  static const bearer = 'Bearer';
  static const authorizationHeader = 'Authorization';

  static const appVersionCode = 'app-version-code';
  static const appVersionName = 'app-version-name';
  static const platform = 'platform';
  static const packageName = 'package-name';

  static const String baseProdUrl = "https://corp.applifting.cz/api/v1/";
  static const String baseStageUrl =
      "https://staging.corp.applifting.cz/api/v1/";

  static const int timeoutInMs = 10000;

  static const Duration maxCacheAge = Duration(hours: 1);
}
