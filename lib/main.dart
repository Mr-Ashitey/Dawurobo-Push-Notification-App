import 'package:flutter/material.dart';

import 'services/notification.dart';
import 'views/home/home.dart';

// starting point of application
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // initialise notification api
    NotificationApi.init();
    return MaterialApp(
      // define theme to be used across applications
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
      ),
      home: const Home(),
    );
  }
}
