import 'package:flutter/material.dart';
import 'package:pixlogtest/app/controller/intl_resource_controller.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IntlResourceController(),
      child: const App(),
    ),
  );
}
