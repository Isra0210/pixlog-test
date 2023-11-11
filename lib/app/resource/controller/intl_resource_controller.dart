import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pixlogtest/app/resource/model/intl_resource_model.dart';
import 'package:http/http.dart' as http;
import 'package:pixlogtest/helper/api_error_helper.dart';
import 'package:pixlogtest/helper/constants_helper.dart';
import 'package:pixlogtest/helper/storage_helper.dart';

import '../../../helper/enum_helper.dart';

class IntlResourceController extends ChangeNotifier {
  IntlResourceController();
  final storage = StorageHelper();
  final apiError = ApiErrorHelper();

  final List<IntlResourceModel> _resources = [];
  final List _languages = [];
  final List _modules = [];

  String _search = "";
  String firstTime = FisrtTimeEnum.yes.name;
  String _errorText = "";
  Map groupedResourceListByLanguages = {};
  Map groupedResourceListByModules = {};
  String get errorText => _errorText;

  UnmodifiableListView<IntlResourceModel> get resources => UnmodifiableListView(
        _resources.where(
          (res) =>
              res.resourceId!.toLowerCase().contains(_search.toLowerCase()),
        ),
      );

  UnmodifiableListView get modules => UnmodifiableListView(_modules);

  UnmodifiableListView get languages => UnmodifiableListView(_languages);

  Map groupItemsByLanguage(List<IntlResourceModel> items) {
    return groupBy(items, (item) => item.languageId);
  }

  Map groupItemsByModules(List<IntlResourceModel> items) {
    return groupBy(items, (item) => item.resourceId);
  }

  Future<String?> isFirstTime() async {
    return await storage.getStringFromStorage(
      key: StorageKeysEnum.firstTime,
    );
  }

  Future<List<IntlResourceModel>> getResources() async {
    http.Response? response;
    _errorText = "";
    firstTime = await isFirstTime() ?? FisrtTimeEnum.yes.name;

    if (firstTime == FisrtTimeEnum.no.name) {
      List<IntlResourceModel> list = [];
      if (_resources.isEmpty) {
        list = await getResourcesFromStorage();
        _resources.addAll(list);
      }

      getLanguages();
      getModules();

      return _resources;
    }
    try {
      response = await http.get(Uri.parse(ConstantsHelper.apiUrl));

      // ignore: avoid_function_literals_in_foreach_calls
      (jsonDecode(response.body) as List).forEach((resource) {
        _resources.add(IntlResourceModel.fromMap(resource["resource"]));
      });

      if (response.statusCode == 200) {
        await syncApiDataToStorage();
      } else {
        _errorText = apiError.getErrorByStatusCode(
          response.statusCode,
        );
      }
      await storage.saveStringToStorage(
        key: StorageKeysEnum.firstTime.name,
        value: FisrtTimeEnum.no.name,
      );
    } catch (error) {
      _errorText = error.toString();
    }
    getLanguages();
    getModules();
    notifyListeners();
    return _resources;
  }

  void onSearch(String search) {
    _search = search;

    notifyListeners();
  }

  Future<void> syncApiDataToStorage() async {
    await storage.saveListToStorage(
      list: [..._resources.map((e) => e.toMap())],
      key: StorageKeysEnum.resources,
    );
  }

  Future<List<IntlResourceModel>> getResourcesFromStorage() async {
    if (_resources.isNotEmpty) {
      return _resources;
    }

    final languages = await storage.getListFromStorage(
      key: StorageKeysEnum.languages,
    );

    if (languages == null || languages.isEmpty) {
      await storage.saveStringToStorage(
        key: StorageKeysEnum.firstTime.name,
        value: FisrtTimeEnum.yes.name,
      );
    } else {
      // ignore: avoid_function_literals_in_foreach_calls
      languages.forEach((lang) async {
        List currentList = [];
        currentList = await storage.getListFromStorage(key: lang) ?? [];
        _resources.addAll([
          ..._resources,
          ...currentList.map((res) => IntlResourceModel.fromMap(res))
        ]);
      });
    }

    return _resources;
  }

  void getLanguages() {
    _languages.clear();
    groupedResourceListByLanguages = groupItemsByLanguage(_resources);

    _languages.addAll(groupedResourceListByLanguages.keys);
    notifyListeners();
  }

  void getModules() {
    _modules.clear();
    groupedResourceListByModules = groupItemsByModules(_resources);

    _modules.addAll(groupedResourceListByModules.keys);
    notifyListeners();
  }
}
