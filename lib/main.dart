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
        scaffoldBackgroundColor: Colors.grey[350],
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
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
