import 'dart:io';
import 'package:template/common/extensions/extensions.dart';
import 'package:template/io/services/api/interceptors/user_agent_interceptor.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceInfoProvider = Provider<DeviceInfoProvider>(
  (ref) {
    final device = DeviceInfoProvider();
    return device;
  },
);

class DeviceInfoProvider {
  Future<PlatformDeviceInfo> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidDevice = await deviceInfo.androidInfo;
      return PlatformDeviceInfo(
        deviceBrand: androidDevice.brand.capitalize(),
        deviceModel: androidDevice.model.replaceWithDash(),
        uuid: androidDevice.id,
        osVersion: androidDevice.version.release,
        model: androidDevice.model,
      );
    } else {
      final iosDevice = await deviceInfo.iosInfo;

      return PlatformDeviceInfo(
        deviceBrand: 'Apple',
        uuid: iosDevice.identifierForVendor ?? "unknown",
        osVersion: iosDevice.systemVersion ?? "unknown",
        model: iosDevice.model ?? "unknown",
        deviceModel: iosDevice.model ?? "unknown",
      );
    }
  }
}
