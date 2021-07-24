import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klody/bottomNavigationBar.dart';

class BarGraphPage extends StatefulWidget {
  final List<int> dataList;
  final List<String> dataNameList;

  const BarGraphPage({this.dataList, this.dataNameList});

  @override
  BarGraphPageState createState() =>
      BarGraphPageState(this.dataList, this.dataNameList);
}

class BarGraphPageState extends State<BarGraphPage> {
  final List<int> dataList;
  final List<String> dataNameList;

  BarGraphPageState(this.dataList, this.dataNameList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bar Graph"),
      ),
      body: Center(
        child: Column(
          children: [
            BarChartSample4(
              dataList: dataList,
              dataNameList: dataNameList,
            )
          ],
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
  State<StatefulWidget> createState() =>
      BarChartSample4State(this.dataList, this.dataNameList);
}

class BarChartSample4State extends State<BarChartSample4> {
  final List<int> dataList;
  final List<String> dataNameList;

  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  MediaQueryData _mediaQueryData;
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;
  double _safeAreaHorizontal;
  double _safeAreaVertical;
  double safeBlockHorizontal;
  double safeBlockVertical;
  Orientation _orientation;

  BarChartSample4State(this.dataList, this.dataNameList);

  @override
  Widget build(BuildContext context) {
    log("0:" + dataNameList[0].toString());
    log("1:" + dataNameList[1].toString());
    log("2:" + dataNameList[2].toString());
    log("3:" + dataNameList[3].toString());
    log("4:" + dataNameList[4].toString());

    _mediaQueryData = MediaQuery.of(context);
    _orientation = MediaQuery.of(context).orientation;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    return Expanded(
      child: Container(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 1.77,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
                      getTextStyles: (value) => const TextStyle(
                          color: Color(0xff939393), fontSize: 10),
                      margin: 10,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            log("Case:" + value.toString());
                            return dataNameList[0];
                          case 1:
                            log("Case:" + value.toString());
                            return dataNameList[1];
                          case 2:
                            log("Case:" + value.toString());
                            return dataNameList[2];
                          case 3:
                            log("Case:" + value.toString());
                            return dataNameList[3];
                          case 4:
                            log("Case:" + value.toString());
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
                  groupsSpace: blockSizeHorizontal * 10,
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
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              width: blockSizeHorizontal * 8,
              y: dataList[0].toDouble(),
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              width: blockSizeHorizontal * 8,
              y: dataList[1].toDouble(),
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              width: blockSizeHorizontal * 8,
              y: dataList[2].toDouble(),
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              width: blockSizeHorizontal * 8,
              y: dataList[3].toDouble(),
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 10,
        barRods: [
          BarChartRodData(
              width: blockSizeHorizontal * 8,
              y: dataList[4].toDouble(),
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }
}
