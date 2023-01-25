import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/common/result/result.dart';
import 'package:template/io/services/api/http/http_service.dart';
import 'package:template/io/services/api/http/http_service_providers.dart';
import 'package:template/io/services/local/storage/hive_storage_service.dart';
import 'package:template/io/services/local/storage/storage_service.dart';
import 'package:loggy/loggy.dart';

abstract class UserRepository {
  Future<void> fetchMe();
  Future<bool> isLoggedIn();
}

class UserRepositoryImpl extends UserRepository {
  final HttpService _httpService;
  final StorageService _storageService;

  UserRepositoryImpl(
    HttpService httpService,
    StorageService storageService,
  )   : _httpService = httpService,
        _storageService = storageService;

  @override
  Future<Result<void>> fetchMe() {
    return Result.guardFuture(() async {
      // Just test
      final me = await _httpService.get("me");
      final meCached = await _storageService.get("me");

      await Future.delayed(const Duration(seconds: 2));
      logDebug("Done");
    });
  }

  @override
  Future<bool> isLoggedIn() {
    return _storageService.get("loggedIn");
  }
}

final userRepoProvider = Provider.autoDispose<UserRepository>(
  (ref) {
    final httpService = ref.watch(httpServiceProvider(false));
    final storageService = ref.watch(storageServiceProvider);
    return UserRepositoryImpl(httpService, storageService);
  },
);
