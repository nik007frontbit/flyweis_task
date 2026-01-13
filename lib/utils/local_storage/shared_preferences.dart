import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

/// Legacy wrapper for local storage operations
/// Now uses GetStorage instead of SharedPreferences for better performance
final GetStorage _storage = GetStorage();

/// Set data to local storage
/// Supports: BOOL, DOUBLE, INTEGER, STRING, LIST-OF-STRING
setDataToLocalStorage({
  @required String? dataType,
  @required String? prefKey,
  bool? boolData,
  double? doubleData,
  int? integerData,
  String? stringData,
  List<String>? listOfStringData,
}) async {
  if (prefKey == null) return null;
  
  switch (dataType) {
    case "BOOL":
      return await _storage.write(prefKey, boolData);
    case "DOUBLE":
      return await _storage.write(prefKey, doubleData);
    case "INTEGER":
      return await _storage.write(prefKey, integerData);
    case "STRING":
      return stringData != null 
          ? await _storage.write(prefKey, stringData)
          : "";
    case "LIST-OF-STRING":
      return await _storage.write(prefKey, listOfStringData);
    default:
      return null;
  }
}

/// Get data from local storage
/// Supports: BOOL, DOUBLE, INTEGER, STRING, LIST-OF-STRING
getDataFromLocalStorage({
  @required String? dataType,
  @required String? prefKey,
}) async {
  if (prefKey == null) return null;
  
  switch (dataType) {
    case "BOOL":
      return _storage.read<bool>(prefKey);
    case "DOUBLE":
      return _storage.read<double>(prefKey);
    case "INTEGER":
      return _storage.read<int>(prefKey);
    case "STRING":
      return _storage.read<String>(prefKey);
    case "LIST-OF-STRING":
      return _storage.read<List<String>>(prefKey);
    default:
      return null;
  }
}

/// Remove a key from local storage
Future<bool> removeKeyFromLocalStorage(String prefKey) async {
  await _storage.remove(prefKey);
  return true;
}

/// Clear all local storage
Future clearLocalStorage() async {
  await _storage.erase();
  return true;
}
