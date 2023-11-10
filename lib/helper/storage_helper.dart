import 'package:localstorage/localstorage.dart';

class StorageHelper {
  StorageHelper();

  final LocalStorage storage = LocalStorage('pixlogtest');

  Future<List> getResourcesByLanguageId(
    String languageId,
  ) async {
    await storage.ready;
    final List resources = await storage.getItem(languageId);
    return resources;
  }

  Future<void> saveResourceListByLanguageId(
    Map<String, List<Map<String, dynamic>>> resource,
  ) async {
    await storage.ready;
    await storage.setItem(resource.keys.first, resource[resource.keys.first]);
  }

  Future saveLanguageList(List<String> languages) async {
    await storage.ready;
    await storage.setItem('languages', languages);
  }

  Future<List>? getLanguageList() async {
    await storage.ready;
    final List? resources = await storage.getItem('languages');
    return resources ?? [];
  }
}
