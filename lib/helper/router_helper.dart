import 'package:flutter/material.dart';

import '../app/filter/view/filter_list_view.dart';
import '../app/resource/view/home_page.dart';

class RouterHelper {
  static Map<String, Widget Function(BuildContext)> get routes => {
        HomeView.route: (context) => const HomeView(),
        FilterListView.route: (context) => const FilterListView(),
      };
}
