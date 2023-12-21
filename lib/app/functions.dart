import 'dart:io';

import 'package:advanced_structure_app/domain/model/model.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      //return Android device Info
      var build = await deviceInfoPlugin.androidInfo;
      name = "${build.brand} ${build.model}";
      identifier = build.androidId;
      version = build.version.codename;
    } else if (Platform.isIOS) {
      //return IOS device Info
      var build = await deviceInfoPlugin.iosInfo;
      name = "${build.name} ${build.model}";
      identifier = build.identifierForVendor;
      version = build.systemVersion;
    }
  } on PlatformException {
    //return Adefault data here
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}
