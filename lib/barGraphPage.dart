import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:klody/bottomNavigationBar.dart';


class BarGraphPage extends StatefulWidget {
final List<int> dataList;
  final List<String> dataNameList;

  const BarGraphPage({this.dataList, this.dataNameList});

  @override
  BarGraphPageState createState() => BarGraphPageState(this.dataList, this.dataNameList);
}

class BarGraphPageState extends State<BarGraphPage> {
  final List<int> dataList;
  final List<String> dataNameList;

  BarGraphPageState(this.dataList, this.dataNameList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Page"),
      ),
      body: Center(
        child: Column(
          children: [BarChartSample4(dataList: dataList, dataNameList: dataNameList,)],
        ),
      ),
      bottomNavigationBar: BottomNavBar(indexTab: 2),
    );
  }

}


class BarChartSample4 extends StatefulWidget {
  final List<int> dataList;
  final List<String> dataNameList;

  const BarChartSample4({this.dataList, this.dataNameList});
  @override
  State<StatefulWidget> createState() => BarChartSample4State(this.dataList, this.dataNameList);
}

class BarChartSample4State extends State<BarChartSample4> {
  final List<int> dataList;
  final List<String> dataNameList;
  
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  BarChartSample4State(this.dataList, this.dataNameList);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: AspectRatio(
          aspectRatio: 1.66,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(color: Color(0xff939393), fontSize: 10),
                      margin: 10,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return dataNameList[0];
                          case 1:
                            return dataNameList[1];
                          case 2:
                            return dataNameList[2];
                          case 3:
                            return dataNameList[3];
                          case 4:
                            return dataNameList[4];
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                          color: Color(
                            0xff939393,
                          ),
                          fontSize: 10),
                      margin: 0,
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 10 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xffe7e8ec),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  groupsSpace: 4,
                  barGroups: getData(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            width: 100,
              y: dataList[0].toDouble(),
             
              borderRadius: const BorderRadius.all(Radius.zero)),
          ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            width: 100,
              y: dataList[1].toDouble(),
              
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            width: 100,
              y: dataList[2].toDouble(),
              
              borderRadius: const BorderRadius.all(Radius.zero)),
                  ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            width: 100,
              y: dataList[3].toDouble(),
              
              borderRadius: const BorderRadius.all(Radius.zero)),
          ],
      ),
       BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            width: 100,
              y: dataList[4].toDouble(),
              
              borderRadius: const BorderRadius.all(Radius.zero)),
          ],
      ),
    ];
  }
}