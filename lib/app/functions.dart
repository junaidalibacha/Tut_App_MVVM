import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../domain/models/models.dart';

Future<DeviceInfo> getDeviceDetail() async {
  String name = 'Unknown';
  String identifier = 'Unknown';
  String version = 'Unknown';
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return android device info
      var deviceInfo = await deviceInfoPlugin.androidInfo;
      name = "${deviceInfo.brand} ${deviceInfo.model}";
      identifier = deviceInfo.id;
      version = deviceInfo.version.codename;
    } else if (Platform.isIOS) {
      // retrun iOS device info
      var deviceInfo = await deviceInfoPlugin.iosInfo;
      name = "${deviceInfo.name} ${deviceInfo.model}";
      identifier = deviceInfo.identifierForVendor!;
      version = deviceInfo.systemVersion!;
    }
  } on PlatformException {
    // return default data here
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}
