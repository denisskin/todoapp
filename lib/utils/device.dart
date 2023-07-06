import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:todoapp/utils/utils.dart';

abstract class Device {
  static final _uid = uniqueId();

  static Future<String> getId() async {
    try {
      if (Platform.isAndroid) {
        return (await DeviceInfoPlugin().androidInfo).id;
      } else if (Platform.isIOS) {
        return (await DeviceInfoPlugin().iosInfo).identifierForVendor ?? _uid;
      }
    } catch (e) {
      //
    }
    return _uid;
  }
}
