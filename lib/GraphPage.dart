import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/appTheme.dart';
import 'package:klody/bottomNavigationBar.dart';
import 'package:pie_chart/pie_chart.dart';

class GraphPage extends StatefulWidget {
  //final String selectedPic;
  //GraphPage(this.selectedPic, {Key key}): super(key: key);
  @override
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Klody"),
      ),
      body: Center(
        child: Column(
          children: [
            //Text(widget.selectedPic),
            Container(
              width: 500,
              height: 500,
              alignment: Alignment.center,
              child: PieChart(dataMap: dataMap)),
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
