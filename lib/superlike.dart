import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/appTheme.dart';
import 'package:klody/bottomNavigationBar.dart';
import 'package:pie_chart/pie_chart.dart';

class Superlike extends StatefulWidget {
  final String selectedPic;
  Superlike(this.selectedPic, {Key key}): super(key: key);
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
    };
  @override
  SuperlikeState createState() => SuperlikeState();
}

class SuperlikeState extends State<Superlike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Klody"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.selectedPic),
            PieChart(dataMap: widget.dataMap) ,
            Image.asset('assets/images/background.jpg'),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/page2');
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(KhlodyTheme.superLikeColor)),
                child: Text("To Swipe Page")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(indexTab: 1),
    );
  }
}

