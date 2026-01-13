// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/foundation.dart';
// import 'package:pos_system/utils/other.dart';
//
// import '../config/local_storage.dart';
// import 'local_storage/shared_preferences.dart';
// import 'other.dart';
//
// class RemoteConfigService {
//   static final RemoteConfigService _instance = RemoteConfigService._internal();
//
//   factory RemoteConfigService() => _instance;
//
//   RemoteConfigService._internal();
//
//   final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
//
//   Future<void> init() async {
//     await Firebase.initializeApp();
//
//     await _remoteConfig.setConfigSettings(
//       RemoteConfigSettings(
//         fetchTimeout: const Duration(seconds: 10),
//         minimumFetchInterval: const Duration(seconds: 0), // for debugging
//       ),
//     );
//
//     await _remoteConfig.fetchAndActivate();
//   }
//
//   Future<bool> iosSubscribeOn() async {
//     final String email =
//         await getDataFromLocalStorage(dataType: LocalStorageData.stringType, prefKey: LocalStorageData.email) ?? "";
//
//     if (kIsWeb) return true;
//     if (!Platform.isIOS) return true;
//     return !equalsIgnoreCase(email, "nikhilhirpara04@gmail.com");
//   }
//
//   Future<bool> isOrderVerificationHelpActivate() async {
//     final String email =
//         await getDataFromLocalStorage(dataType: LocalStorageData.stringType, prefKey: LocalStorageData.email) ?? "";
//
//     return await _isEmailInConfigList(email);
//   }
//
//   Future<bool> _isEmailInConfigList(String email) async {
//     String orderVerificationHelpActivateIds = _remoteConfig.getString("ORDER_VERIFICATION_HELP_ACTIVATE");
//
//     if (orderVerificationHelpActivateIds.isNotEmpty) {
//       List<String> activeIdList = orderVerificationHelpActivateIds.trim().split(",").toList();
//       return activeIdList.any((element) => equalsIgnoreCase(element.trim(), email));
//     }
//     return false;
//   }
// }
