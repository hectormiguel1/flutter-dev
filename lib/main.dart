import 'package:flutter/material.dart';
import 'package:pem_app_flutter/screens/login-screen.dart';
import 'package:pem_app_flutter/shared-objects/categories.dart';

void main() {
  runApp(MyApp());
  initCategories();

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PEM',
      darkTheme: darkMode(),
      theme: ThemeData(
        brightness: Brightness.light,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.blue,
        primaryColorDark: Colors.white,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }

  ThemeData darkMode() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue[900],
      accentColor: Colors.blue[700],
      primarySwatch: Colors.blue,
      cardColor: Colors.black,
      canvasColor: Colors.black,
      selectedRowColor: Colors.amber,
      visualDensity: VisualDensity.compact,
      primaryTextTheme: Typography.whiteCupertino,
      textTheme: Typography.whiteCupertino,
      iconTheme: IconThemeData(color: Colors.black),

    );
  }
}


