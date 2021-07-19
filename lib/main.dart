import 'package:flutter/material.dart';
import 'package:klody/dailySwipePage.dart';
import 'package:klody/login.dart';
import 'package:klody/trainingSwipePage.dart';
import 'package:klody/graphPage.dart';

import 'appTheme.dart';
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
// TODO: the fallback method to call lambda and get new ip address if 404. log in implemented only
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: "Khlody",
        theme: ThemeData(
          primaryColor: Color(KhlodyTheme.primaryTheme),
          buttonColor: Color(KhlodyTheme.superLikeColor),
          scaffoldBackgroundColor: Color(KhlodyTheme.backgroundColor),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Color(KhlodyTheme.bottomNavBarColor)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LogInPage(),
          '/training': (context) => TrainingSwipePage(),
          '/graph': (context) => GraphPage(),
          '/daily': (context) => DailySwipePage(),

        });
  }
}
