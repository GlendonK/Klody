import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottomNavigationBar.dart';

class DailySwipePage extends StatefulWidget {
  @override
  DailySwipePageState createState() => DailySwipePageState();

  
  }

class DailySwipePageState extends State<DailySwipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Page"),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: BottomNavBar(indexTab: 1),
    );
  }
  }
