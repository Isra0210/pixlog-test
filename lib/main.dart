import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pixlogtest/app/resource/controller/intl_resource_controller.dart';
import 'package:provider/provider.dart';

import 'app/resource/app.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ChangeNotifierProvider(
      create: (context) => IntlResourceController(),
      child: const App(),
    ),
  );
  FlutterNativeSplash.remove();
}
