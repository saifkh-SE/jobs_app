import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Jobs App',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            // visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: HomePage(),
        );
      },
    );
  }
}
