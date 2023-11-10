import 'package:flutter/material.dart';

import '../app/view/home_page.dart';

class RouterHelper {
  static Map<String, Widget Function(BuildContext)> get routes => {
        HomeView.route: (context) => const HomeView(),
      };
}
