import 'package:localstorage/localstorage.dart';
import 'package:pixlogtest/helper/enum_helper.dart';

class StorageHelper {
  StorageHelper();

  final LocalStorage storage = LocalStorage('pixlog');

  Future<List>? getListFromStorage({required StorageKeysEnum key}) async {
    await storage.ready;
    final List? resources = await storage.getItem(key.name);
    return resources ?? [];
  }

  Future saveListToStorage({
    required List list,
    required StorageKeysEnum key,
  }) async {
    await storage.ready;
    await storage.setItem(key.name, list);
  }

  Future<void> saveMapToStorage({
    required Map<String, List<Map<String, dynamic>>> map,
  }) async {
    await storage.ready;
    await storage.setItem(map.keys.first, map[map.keys.first]);
  }

  Future<String?> getStringFromStorage({required StorageKeysEnum key}) async {
    await storage.ready;
    final String? isFirstTime = await storage.getItem(key.name);
    return isFirstTime;
  }

  Future<void> saveStringToStorage({
    required String key,
    required String value,
  }) async {
    await storage.ready;
    await storage.setItem(key, value);
  }
}
