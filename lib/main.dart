import 'package:flutter/material.dart';
import 'package:klody/login.dart';
import 'package:klody/swipePage.dart';

void main() {
  runApp(MyApp());}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
  
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "Khlody",
    theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: '/',
    routes: {
      '/': (context) => LogInPage(),
      '/page2': (context) => SwipePage()
    }
  );
  }
  
}