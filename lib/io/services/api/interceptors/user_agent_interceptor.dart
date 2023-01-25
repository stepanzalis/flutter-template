import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:template/common/constants/constants.dart';
import 'package:template/common/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserAgentInterceptor extends QueuedInterceptor {
  late final DeviceInfoPlugin _deviceInfo;
  PackageInfo? _packageInfo;
  String? _userAgent;

  UserAgentInterceptor({
    required final DeviceInfoPlugin deviceInfo,
  }) : _deviceInfo = deviceInfo;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _initPackageInfo();
    options.headers[HttpHeaders.userAgentHeader] = await _getUserAgent();
    options.headers[ApiConstants.appVersionCode] = _packageInfo?.buildNumber;
    options.headers[ApiConstants.appVersionName] = _packageInfo?.version;
    options.headers[ApiConstants.platform] = Platform.isIOS ? 'iOS' : 'Android';
    options.headers[ApiConstants.packageName] = _packageInfo?.packageName;
    handler.next(options);
  }

  Future<PackageInfo> _initPackageInfo() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  /// User agent is not important, can be cached
  /// Build number are get directly to have actual value
  Future<String> _getUserAgent() async {
    if (_userAgent != null) return _userAgent!;

    final deviceInfo = await _getDeviceInfo();
    final agent =
        '${_packageInfo?.appName}/${_packageInfo?.version}/${_packageInfo?.buildNumber}/${_packageInfo?.packageName} ${Platform.operatingSystem.capitalize()}/${deviceInfo.osVersion} (${deviceInfo.deviceBrand}_${deviceInfo.deviceModel};${deviceInfo.uuid})';
    _userAgent ??= agent;
    return agent;
  }

  Future<PlatformDeviceInfo> _getDeviceInfo() async {
    if (Platform.isAndroid) {
      final androidDevice = await _deviceInfo.androidInfo;
      return PlatformDeviceInfo(
        deviceBrand: androidDevice.brand.capitalize(),
        deviceModel: androidDevice.model.replaceWithDash(),
        uuid: androidDevice.id,
        osVersion: androidDevice.version.release,
        model: androidDevice.model,
      );
    } else {
      final iosDevice = await _deviceInfo.iosInfo;
      return PlatformDeviceInfo(
        deviceBrand: "Apple",
        deviceModel: iosDevice.model?.replaceWithDash() ?? "unknown",
        uuid: iosDevice.identifierForVendor ?? "unknown",
        osVersion: iosDevice.systemVersion ?? "unknown",
        model: iosDevice.model ?? "unknown",
      );
    }
  }
}

@immutable
class PlatformDeviceInfo {
  final String deviceBrand;
  final String deviceModel;
  final String uuid;
  final String osVersion;
  final String model;

  const PlatformDeviceInfo({
    required this.deviceBrand,
    required this.deviceModel,
    required this.osVersion,
    required this.uuid,
    required this.model,
  });

  factory PlatformDeviceInfo.empty() => const PlatformDeviceInfo(
        deviceBrand: "",
        deviceModel: "",
        uuid: "",
        model: "",
        osVersion: "",
      );
}
