import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionShell {
   Future<void> saveFile({
    required Future<void> Function() androidLogic,
    required Future<void> Function() iosLogic,
  }) async {
    try {
      if (Platform.isAndroid) {
        // Check if the app is running on Android
        // and get the Android SDK version
        final sdkVersion = await _getAndroidSdkVersion();
        // Check if the app is running on Android 11 or higher
        // and request the necessary permissions
        final hasPermission = await _handleAndroidPermissions(sdkVersion);

        if (hasPermission) {
          await androidLogic();
        } else {
          if (sdkVersion >= 30) {
            // Only open settings for Android 11+
            await openAppSettings();
          } else {
            debugPrint('Storage permission required for Android <11');
            // Consider showing a dialog instead of SnackBar for better UX
          }
        }
      } else if (Platform.isIOS) {
        await iosLogic();
      }
    } on PlatformException catch (e) {
      debugPrint('Permission error: ${e.message}');
      rethrow;
    }
    return Future.value();
  }

  Future<bool> _handleAndroidPermissions(int sdkVersion) async {
    // if android version is 30 or above, check for manageExternalStorage permission
    // else check for storage permission
    final requiredPermission =
        sdkVersion >= 30 ? Permission.manageExternalStorage : Permission.storage;

    return requiredPermission.isGranted;
  }

  /// Get the Android SDK version
  /// This method uses the device_info_plus package to retrieve the SDK version.
  Future<int> _getAndroidSdkVersion() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt;
  }
}
