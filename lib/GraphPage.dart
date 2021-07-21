import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klody/appTheme.dart';
import 'package:klody/bottomNavigationBar.dart';
import 'package:klody/dataVisualData.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:klody/webApi.dart';


class GraphPage extends StatefulWidget {
  //final String selectedPic;
  //GraphPage(this.selectedPic, {Key key}): super(key: key);
  @override
  GraphPageState createState() => GraphPageState();
  }

class GraphPageState extends State<GraphPage> {
  
  DataVisualData dataVisual;
  Map<String, int> temp = {};
  Map<String, double> top5Data = {};
  double percentage = 0;

  Future<Map<String, double>> getData() async{
  await DataVisualizationApi().clientVisualization().then((value) {dataVisual = value;});
    log("test");
    
    temp["i5OClockShadow"] = dataVisual.i5OClockShadow;
    temp["archedEyebrows"] = dataVisual.archedEyebrows;
    temp["bagsUnderEyes"] = dataVisual.bagsUnderEyes;
    temp["bald"] = dataVisual.bald;
    temp["bangs"] = dataVisual.bangs;
    temp["bigLips"] = dataVisual.bigLips;
    temp["bigNose"] = dataVisual.bigNose;
    temp["blackHair"] = dataVisual.blackHair;
    temp["blondHair"] = dataVisual.blondHair;
    temp["blurry"] = dataVisual.blurry;
    temp["brownHair"] = dataVisual.brownHair;
    temp["bushyEyebrows"] = dataVisual.bushyEyebrows;
    temp["chubby"] = dataVisual.chubby;
    temp["doubleChin"] = dataVisual.doubleChin;
    temp["eyeglasses"] = dataVisual.eyeglasses;
    temp["grayHair"] = dataVisual.grayHair;
    temp["heavyMakeup"] = dataVisual.heavyMakeup;
    temp["highCheekbones"] = dataVisual.highCheekbones;
    temp["mouthSlightlyOpen"] = dataVisual.mouthSlightlyOpen;
    temp["narrowEyes"] = dataVisual.narrowEyes;
    temp["ovalFace"] = dataVisual.ovalFace;
    temp["paleSkin"] = dataVisual.paleSkin;
    temp["pointyNose"] = dataVisual.pointyNose;
    temp["recedingHairline"] = dataVisual.recedingHairline;
    temp["rosyCheeks"] = dataVisual.rosyCheeks;
    temp["sideburns"] = dataVisual.sideburns;
    temp["smiling"] = dataVisual.smiling;
    temp["straightHair"] = dataVisual.straightHair;
    temp["wavyHair"] = dataVisual.wavyHair;
    temp["wearingEarrings"] = dataVisual.wearingEarrings;
    temp["wearingHat"] = dataVisual.wearingHat;
    temp["wearingLipstick"] = dataVisual.wearingLipstick;
    temp["wearingNecklace"] = dataVisual.wearingNecklace;
    temp["wearingNecktie"] = dataVisual.wearingNecktie;
    temp["young"] = dataVisual.young;

    //sort map in desc
    var sortedEntries = temp.entries.toList()..sort((e1, e2) 
    {
      var diff = e2.value.compareTo(e1.value);
      if (diff == 0) diff = e2.key.compareTo(e1.key);
        return diff;
    });

    //replace map values with sorted values
    temp..clear()..addEntries(sortedEntries);

    int total = 0;
    //calculate total value
    temp.forEach((key, value)
    {
      total += value;
      //print(total);
    });

    // calculate percentage
    for( int i = 0; i<=4; i ++)
    {
      percentage = temp.values.elementAt(i)/total*100;
      top5Data[temp.keys.elementAt(i)] = percentage;
      //print(top5Data);
    }
    return top5Data;

    
  }
  
  
  @override
  Widget build(BuildContext context) {  
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
              
              child:FutureBuilder<Map<String, double>>(
              future: getData(),
              builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PieChart(dataMap: top5Data);
              }
              else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

    // By default, show a loading spinner.
    return CircularProgressIndicator();
  },
)),//PieChart(dataMap: top5Data)),
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
