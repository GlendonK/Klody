import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  @override
  SwipePageState createState() => SwipePageState();
  
}

class SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
        appBar: AppBar(title: Text("Swipe Page"),
        ),
        body: Center(child: Column(children: [Text("Swipe PAge")],
        ),
        ),
        ),
    );
    }

}

