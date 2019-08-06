import 'package:flutter/material.dart';
import 'package:flutter_app_2/app.dart';
import 'package:flutter_app_2/screens/start.dart';

main() {
  runApp(MaterialApp(
    home: StartPage(),
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/start': (context) => StartPage(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/add_new': (context) => FuelApp(),
    },
  ));
}
