import 'dart:developer';
import 'package:template/common/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'storage_service.dart';

final storageServiceProvider = Provider<StorageService>(
  (_) => throw UnimplementedError(),
);

class HiveStorageService implements StorageService {
  Box? _hiveBox;

  @override
  Future<void> init() async {
    await _openBox();
  }

  @override
  Future<void> remove(String key) async {
    await _hiveBox?.delete(key);
  }

  @override
  T get<T>(String key, [T? defaultValue]) {
    return _hiveBox?.get(key, defaultValue: defaultValue);
  }

  @override
  List<T> getAll<T>() {
    try {
      return _hiveBox?.values.cast<T>().toList() ?? [];
    } catch (e) {
      log("❌ Could not cast list to $T");
      return [];
    }
  }

  @override
  bool has(String key) {
    return _hiveBox?.containsKey(key) ?? false;
  }

  @override
  Future<void> set(String key, dynamic data) async {
    await _hiveBox?.put(key, data);
  }

  @override
  Future<void> clear() async {
    await _hiveBox?.clear();
  }

  @override
  Future<void> close() async {
    await _hiveBox?.close();
  }

  Future<void> _openBox([String boxName = HiveConstants.preferencesBox]) async {
    _hiveBox = await Hive.openBox(boxName);
  }
}
