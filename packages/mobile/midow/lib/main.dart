import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:midow/screen/home.dart';

void backgroundFetchHeadlessTask() async {
  print('[BackgroundFetch] Headless event received.');
  BackgroundFetch.finish();
}

void main() {
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static const Color PRIMARY = Color(0xFFA587E8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(
                      color: PRIMARY,
                      fontWeight: FontWeight.bold,
                      fontSize: 17))),
          primarySwatch: Colors.blue,
          primaryColor: PRIMARY),
      home: HomePage(),
    );
  }
}
