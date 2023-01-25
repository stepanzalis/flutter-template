/// Base class for all app exceptions
class AppException implements Exception {}

/// Thrown when HTTP error occurred
class HttpException implements AppException {
  final String? title;
  final String? message;
  final int? statusCode;

  HttpException({
    this.title,
    this.message,
    this.statusCode,
  });
}

/// Thrown when device has no internet connection
class NoInternetException implements AppException {
  final String message;
  NoInternetException({this.message = 'No internet connection.'});
}

/// Thrown when URL is not valid
class InvalidBaseUrlException implements Exception {
  final String url;
  final String message;

  InvalidBaseUrlException(this.url, {this.message = 'This url is not valid.'});
}

/// Thrown router param is missing
class RouteException implements AppException {
  final String message;
  RouteException({
    this.message = 'No param to route is given. Check if navigation query param is not missing.',
  });
}

/// Thrown router param is missing
class IllegalArgumentException implements AppException {
  final String message;
  IllegalArgumentException(this.message);
}
