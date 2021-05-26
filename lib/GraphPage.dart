import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/bottomNavigationBar.dart';

class GraphPage extends StatefulWidget {
  @override
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends State<GraphPage> {

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Klody"),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/background.jpg'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/page2');
                },
                child: Text("To Swipe Page")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(indexTab: 1),
    );
  }
}
