import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pixlogtest/app/model/intl_resource_model.dart';
import 'package:http/http.dart' as http;
import 'package:pixlogtest/helper/api_error_helper.dart';
import 'package:pixlogtest/helper/constants_helper.dart';
import 'package:pixlogtest/helper/storage_helper.dart';

class IntlResourceController extends ChangeNotifier {
  IntlResourceController();

  final storageHelper = StorageHelper();
  final apiErrorHelper = ApiErrorHelper();
  final List<IntlResourceModel> _resources = [];
  final List _languages = [];

  bool isLoading = false;

  String _search = "";
  String _errorText = "";
  Map groupedList = {};
  String get errorText => _errorText;

  UnmodifiableListView<IntlResourceModel> get resources => UnmodifiableListView(
        _resources,
      );

  UnmodifiableListView get languages => UnmodifiableListView(
        _languages.where(
          (lang) =>
              lang.toString().toLowerCase().contains(_search.toLowerCase()),
        ),
      );

  Map groupItemsByLanguageId(List<IntlResourceModel> items) {
    return groupBy(items, (item) => item.languageId);
  }

  Future<List> getAvailableLanguages() async {
    http.Response? response;
    final list = await storageHelper.getLanguageList();

    try {
      if (list != null && _languages.isEmpty) {
        _languages.addAll(list);
        return _languages;
      }
      if (_languages.isNotEmpty) {
        return _languages;
      }
      isLoading = true;

      response = await http.get(Uri.parse(ConstantsHelper.apiUrl));

      // ignore: avoid_function_literals_in_foreach_calls
      (jsonDecode(response.body) as List).forEach((resource) {
        _resources.add(IntlResourceModel.fromMap(resource["resource"]));
        if (!_languages.contains(resource["resource"]["language_id"])) {
          _languages.add(resource["resource"]["language_id"]);
        }
      });

      if (response.statusCode == 200) {
        syncResourceListToStorage();
      } else {
        _errorText = apiErrorHelper.getErrorByStatusCode(
          response.statusCode,
        );
      }
    } catch (error) {
      _errorText = error.toString();
    }
    isLoading = false;
    notifyListeners();
    return _languages;
  }

  void onSearchLanguage(String search) {
    _search = search;

    notifyListeners();
  }

  Future<void> syncResourceListToStorage() async {
    groupedList = groupItemsByLanguageId(_resources);
    await storageHelper.saveLanguageList(List<String>.from(groupedList.keys));

    groupedList.forEach((key, value) async {
      await storageHelper.saveResourceListByLanguageId(
        {
          key: [...(value as List<IntlResourceModel>).map((e) => e.toMap())]
        },
      );
    });
  }
  
  Future<List<IntlResourceController>> getResourcesByLanguageId(String languageId) async {
    final getListFromStorage = await storageHelper.getResourcesByLanguageId(languageId);
      
    return [];
  }
}
