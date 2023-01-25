import 'package:template/common/error/exceptions.dart';
import 'package:template/common/result/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  Result._();

  factory Result.loading() = Loading;
  factory Result.success(T value) = Success<T>;
  factory Result.error(AppError error) = Error<T>;

  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(body());
    } on Exception catch (e) {
      return Result.error(AppError.fromException(e));
    }
  }

  static Future<Result<T>> guardFuture<T>(Future<T> Function() future) async {
    try {
      return Result.success(await future());
    } on Exception catch (e) {
      return Result.error(AppError.fromException(e));
    }
  }

  bool get isSuccess => maybeWhen(
        success: (data) => true,
        error: (_) => false,
        orElse: () => false,
      );

  bool get isFailure => !isSuccess;

  T get dataOrThrow {
    return when(
      loading: () => throw StateError('Result is loading'),
      success: (value) => value,
      error: (e) => throw e,
    );
  }

  T getOrElse(Function() orElse) {
    return maybeWhen(
      success: (value) => value,
      orElse: () => orElse(),
    );
  }

  Result<Res> chain<Res>(Res Function(T value) cb) {
    return when(
      loading: () => Result.loading(),
      error: (err) => Result.error(err),
      success: (value) {
        try {
          return Result.success(cb(value));
        } on Exception catch (e) {
          return Result.error(AppError.fromException(e));
        }
      },
    );
  }

  static Result failIf(bool Function() verify, String reason) {
    if (verify()) {
      return Result.error(
        AppError.fromException(IllegalArgumentException(reason)),
      );
    }

    return Result.success(null);
  }

  void ifFailure(Function(AppError e) body) {
    maybeWhen(
      error: (e) => body(e),
      orElse: () {
        // no-op
      },
    );
  }
}

extension ResultObjectExt<T> on T {
  Result<T> get asSuccess => Result.success(this);

  Result<T> asFailure(Exception e) => Result.error(AppError.fromException(e));
}
