// import 'dart:io';
//
// import 'package:android_id/android_id.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:pos_system/utils/local_storage/shared_preferences.dart';
//
// import '../../config/local_storage.dart';
//
// Future<Map<String, String>> defaultApiParams() async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//
//   // Device ID
//   String? deviceId = await getDataFromLocalStorage(
//     dataType: LocalStorageData.stringType,
//     prefKey: LocalStorageData.deviceId,
//   );
//
//   if (deviceId?.isEmpty ?? true) {
//     final newDeviceId = await getDeviceId();
//     await setDataToLocalStorage(
//       dataType: LocalStorageData.stringType,
//       prefKey: LocalStorageData.deviceId,
//       stringData: newDeviceId,
//     );
//   }
//
//   // FCM Token
//   String? fcmToken = await getDataFromLocalStorage(
//     dataType: LocalStorageData.stringType,
//     prefKey: LocalStorageData.fcmToken,
//   );
//
//   if (fcmToken?.isEmpty ?? true) {
//     final FirebaseMessaging fcm = FirebaseMessaging.instance;
//     final token = await fcm.getToken();
//     await setDataToLocalStorage(
//       dataType: LocalStorageData.stringType,
//       prefKey: LocalStorageData.fcmToken,
//       stringData: token.toString(),
//     );
//   }
//
//   // Build final API parameter map
//   Map<String, String> defaultApiMap = {
//     "login_parent_id": await getDataFromLocalStorage(
//       dataType: LocalStorageData.stringType,
//       prefKey: LocalStorageData.chemistId,
//     ) ??
//         "0",
//     "chemist_id": await getDataFromLocalStorage(
//       dataType: LocalStorageData.stringType,
//       prefKey: LocalStorageData.userId,
//     ) ??
//         "0",
//     "device_id": await getDataFromLocalStorage(
//       dataType: LocalStorageData.stringType,
//       prefKey: LocalStorageData.deviceId,
//     ) ??
//         "",
//     "accesstoken": await getDataFromLocalStorage(
//       dataType: LocalStorageData.stringType,
//       prefKey: LocalStorageData.accessToken,
//     ) ??
//         "0",
//     "fcmtoken": await getDataFromLocalStorage(
//       dataType: LocalStorageData.stringType,
//       prefKey: LocalStorageData.fcmToken,
//     ) ??
//         "",
//     "app_version": packageInfo.buildNumber,
//     "os": Platform.isAndroid ? "android" : "ios",
//   };
//
//   return defaultApiMap;
// }
//
// Future<Map<String, String>> getDeviceInfo() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   Map<String, String> map = {};
//
//   if (Platform.isAndroid) {
//     var info = await deviceInfo.androidInfo;
//     map['os'] = "android";
//     map['device_sdk_version'] = "${info.version.sdkInt}";
//     map['device_release'] = "${info.version.release}";
//     map['device_name'] = "${info.brand}";
//     map['device_manufacture'] = "${info.manufacturer}";
//     map['device_model'] = "${info.model}";
//   } else {
//     var info = await deviceInfo.iosInfo;
//     map['os'] = "ios";
//     map['device_sdk_version'] = "${info.systemVersion}";
//     map['device_release'] = "${info.utsname.release}";
//     map['device_name'] = "${info.utsname.machine}";
//     map['device_manufacture'] = "${info.name}";
//     map['device_model'] = "${info.model}";
//   }
//
//   return map;
// }
//
// Future<String?> getDeviceId() async {
//   var deviceInfo = DeviceInfoPlugin();
//   if (Platform.isIOS) {
//     // import 'dart:io'
//     var iosDeviceInfo = await deviceInfo.iosInfo;
//     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//   } else if (Platform.isAndroid) {
//     var androidId = await const AndroidId().getId() ?? 'Unknown ID';
//     return androidId; // unique ID on Android
//   }
//   return "";
// }