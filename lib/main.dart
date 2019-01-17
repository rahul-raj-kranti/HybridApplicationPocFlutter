import 'package:flutter/material.dart';
import 'package:edumarshal/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edumarshal Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        hintColor: Colors.white,
        highlightColor: Colors.white,
        buttonColor: Colors.lightBlue,
        errorColor: Colors.red,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      routes: routes,
    );
  }
}
