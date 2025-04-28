import 'dart:developer' as developer;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb and defaultTargetPlatform
import 'package:flutter/services.dart';

// How to use this class:

/*

final sdk = (await DeviceInfo.getDeviceInfo())[DeviceInfo.keyAndroidVersionSdkInt];

 final deviceInfo = await DeviceInfo.getDeviceInfo();
 final sdk = deviceInfo[DeviceInfo.keyAndroidVersionSdkInt];

*/

class DeviceInfo {
  static const String keyPlatform = 'platform';
  static const String keyError = 'error'; // Key used if fetching info fails
  static const String keyDetails = 'details'; // Details about the error

  // Common Keys (May exist on multiple platforms)
  static const String keyName = 'name'; // e.g., Device name (iOS), Distro name (Linux)
  static const String keyModel = 'model';
  static const String keyIsPhysicalDevice = 'isPhysicalDevice';
  static const String keyId = 'id'; // e.g., Distro ID (Linux)
  static const String keyComputerName = 'computerName'; // (Windows/macOS)
  static const String keySystemVersion = 'systemVersion'; // e.g., OS version (iOS)
  static const String keyOsRelease = 'osRelease'; // e.g., OS release version (macOS)
  static const String keyMajorVersion = 'majorVersion'; // (Windows/macOS)
  static const String keyMinorVersion = 'minorVersion'; // (Windows/macOS)

  // Android Specific Keys
  static const String keyAndroidVersionSecurityPatch = 'android.version.securityPatch';
  static const String keyAndroidVersionSdkInt = 'android.version.sdkInt';
  static const String keyAndroidVersionRelease = 'android.version.release';
  static const String keyAndroidManufacturer = 'android.manufacturer';
  static const String keyAndroidBrand = 'android.brand'; // Often similar to manufacturer
  static const String keyAndroidBoard = 'android.board';
  static const String keyAndroidHardware = 'android.hardware';

  // iOS Specific Keys
  static const String keyIosSystemName = 'ios.systemName'; // e.g., "iOS"
  static const String keyIosIdentifierForVendor =
      'ios.identifierForVendor'; // Unique ID per app vendor
  static const String keyIosUtsnameMachine = 'ios.utsname.machine'; // e.g., "iPhone13,3"

  // Web Specific Keys
  static const String keyWebBrowserName = 'web.browserName';
  static const String keyWebUserAgent = 'web.userAgent';
  static const String keyWebPlatform = 'web.platform'; // Platform reported by browser JS

  // Linux Specific Keys
  static const String keyLinuxPrettyName =
      'linux.prettyName'; // e.g., "Ubuntu 22.04.1 LTS"
  static const String keyLinuxVersionId = 'linux.versionId';

  // Windows Specific Keys
  static const String keyWindowsNumberOfCores = 'windows.numberOfCores';
  static const String keyWindowsSystemMemoryInMB = 'windows.systemMemoryInMB';
  static const String keyWindowsProductName = 'windows.productName';
  static const String keyWindowsBuildNumber = 'windows.buildNumber';

  // macOS Specific Keys
  static const String keyMacOsArch = 'macos.arch';
  static const String keyMacOsKernelVersion = 'macos.kernelVersion';
  static const String keyMacOsMemorySize = 'macos.memorySize'; // In bytes
  static const String keyMacOsHostName = 'macos.hostName';

  // --- Private Plugin Instance ---
  static final _deviceInfo = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    var deviceData = <String, dynamic>{};
    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await _deviceInfo.webBrowserInfo);
      } else {
        deviceData = switch (defaultTargetPlatform) {
          TargetPlatform.android => _readAndroidBuildData(await _deviceInfo.androidInfo),
          TargetPlatform.iOS => _readIosDeviceInfo(await _deviceInfo.iosInfo),
          TargetPlatform.linux => _readLinuxDeviceInfo(await _deviceInfo.linuxInfo),
          TargetPlatform.windows => _readWindowsDeviceInfo(await _deviceInfo.windowsInfo),
          TargetPlatform.macOS => _readMacOsDeviceInfo(await _deviceInfo.macOsInfo),
          TargetPlatform.fuchsia => <String, dynamic>{
              keyError: "Fuchsia platform isn't supported by this helper",
            },
        };
      }
    } on PlatformException catch (e, stack) {
      developer.log('Failed to get platform info', error: e, stackTrace: stack);
      deviceData = <String, dynamic>{
        keyError: 'Failed to get platform version.',
        keyDetails: e.message,
      };
    } on Exception catch (e, stack) {
      // Catch potential other errors during data reading
      developer.log('Error reading device info', error: e, stackTrace: stack);
      deviceData = <String, dynamic>{
        keyError: 'Failed to read device info.',
        keyDetails: e.toString(),
      };
    }
    return deviceData;
  }

  // --- Helper methods to convert specific info to Map using constants ---

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      keyPlatform: 'Android',
      keyAndroidVersionSecurityPatch: build.version.securityPatch,
      keyAndroidVersionSdkInt: build.version.sdkInt,
      keyAndroidVersionRelease: build.version.release,
      keyAndroidManufacturer: build.manufacturer,
      keyAndroidBrand: build.brand,
      keyModel: build.model,
      keyIsPhysicalDevice: build.isPhysicalDevice,
      keyAndroidBoard: build.board,
      keyAndroidHardware: build.hardware,
      // Add other desired Android fields using constants here
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      keyPlatform: 'iOS',
      keyName: data.name,
      keyIosSystemName: data.systemName,
      keySystemVersion: data.systemVersion,
      keyModel: data.model,
      keyIsPhysicalDevice: data.isPhysicalDevice,
      keyIosIdentifierForVendor: data.identifierForVendor,
      keyIosUtsnameMachine: data.utsname.machine,
      // Add other desired iOS fields using constants here
    };
  }

  static Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      keyPlatform: 'Web',
      keyWebBrowserName: data.browserName.name,
      keyWebUserAgent: data.userAgent,
      keyWebPlatform: data.platform, // Platform reported by browser JS
      // Add other desired Web fields using constants here
    };
  }

  static Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      keyPlatform: 'Linux',
      keyName: data.name,
      keyLinuxPrettyName: data.prettyName,
      keyId: data.id,
      keyLinuxVersionId: data.versionId,
    };
  }

  static Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      keyPlatform: 'Windows',
      keyComputerName: data.computerName,
      keyWindowsNumberOfCores: data.numberOfCores,
      keyWindowsSystemMemoryInMB: data.systemMemoryInMegabytes,
      keyWindowsProductName: data.productName,
      keyWindowsBuildNumber: data.buildNumber,
      keyMajorVersion: data.majorVersion,
      keyMinorVersion: data.minorVersion,
      // Add other desired Windows fields using constants here
    };
  }

  static Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      keyPlatform: 'macOS',
      keyComputerName: data.computerName,
      keyMacOsHostName: data.hostName,
      keyMacOsArch: data.arch,
      keyModel: data.model,
      keyMacOsKernelVersion: data.kernelVersion,
      keyOsRelease: data.osRelease,
      keyMajorVersion: data.majorVersion,
      keyMinorVersion: data.minorVersion,
      keyIsPhysicalDevice: true, // macOS is always physical in this context
      keyMacOsMemorySize: data.memorySize, // In bytes
      // Add other desired macOS fields using constants here
    };
  }
}
