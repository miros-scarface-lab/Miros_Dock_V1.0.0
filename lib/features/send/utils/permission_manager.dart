import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionManager {
  static Future<bool> requestAllPermissions() async {
    if (!Platform.isAndroid) return true;

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    // Request Manage External Storage for Android 11+ to ensure 
    // files are visible in standard File Manager apps.
    if (sdkInt >= 30) {
      if (!await Permission.manageExternalStorage.isGranted) {
        await Permission.manageExternalStorage.request();
      }
    }

    Map<Permission, PermissionStatus> statuses = {};

    if (sdkInt >= 33) {
      statuses = await [
        Permission.photos,
        Permission.videos,
        Permission.audio,
        Permission.nearbyWifiDevices,
        Permission.notification,
      ].request();
    } else {
      statuses = await [
        Permission.storage,
        Permission.location,
      ].request();
    }

    return statuses.values.every((status) => status.isGranted || status.isLimited);
  }
}



