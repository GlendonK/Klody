import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/appTheme.dart';
import 'package:klody/bottomNavigationBar.dart';
import 'package:klody/dataVisualData.dart';
import 'package:klody/webApi.dart';
import 'package:pie_chart/pie_chart.dart';

class GraphPage extends StatefulWidget {
  //final String selectedPic;
  //GraphPage(this.selectedPic, {Key key}): super(key: key);
  
  @override
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends State<GraphPage> {
  DataVisualData dataVisual;

  @override
  void initState() {
    super.initState();
    log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    getData();
    Future.delayed(Duration(seconds: 5));
    //WidgetsBinding.instance.addPostFrameCallback((_) {getData(); });
    //Future.delayed(Duration.zero, ()=>getData());
  
        
  }
  
  Future<DataVisualData> getData() async{
    await DataVisualizationApi().clientVisualization().then((value) {dataVisual = value;});
    log("1st"+dataVisual.bald.toString());
    return dataVisual;
  }

 

  

  @override
  Widget build(BuildContext context) {
   var test = "";
   test =dataVisual.bald.toString();
    log("2nd"+ test);

    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };

    if (test == null) {
      return CircularProgressIndicator();
    } else {
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
                  Navigator.pushNamed(context, '/training');
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(KhlodyTheme.superLikeColor)),
                child: Text("To Swipe Page")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(indexTab: 2),
    );
    }
    
  }
}
