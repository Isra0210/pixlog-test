import 'package:flutter/material.dart';
import 'package:pixlogtest/app/view/home_page.dart';

import '../helper/router_helper.dart';
import '../utils/theme/custom_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixlog Test',
      theme: CustomTheme.theme(),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.route,
      routes: RouterHelper.routes,
    );
  }
}
