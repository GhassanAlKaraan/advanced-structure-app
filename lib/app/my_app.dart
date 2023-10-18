import 'package:advanced_structure_app/presentation/theme_manager.dart';
import 'package:flutter/material.dart';

// * Application class
class MyApp extends StatelessWidget {
  // * Factory constructor
  // factory MyApp() => instance;
  factory MyApp() {
    return instance;
  }

  // * Named constructor - we don't need it
  // const MainApp({super.key});

  // * Private named constructor
  // const MyApp._internal();
  MyApp._internal();

  // * Single instance - singleton
  //static const MyApp instance = MyApp._internal();
  static final MyApp instance = MyApp._internal();

  int appState = 0; //var

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
