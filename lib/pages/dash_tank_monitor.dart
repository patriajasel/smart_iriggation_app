import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';

bluetooth_conn btInstance = bluetooth_conn();
int? waterLevel;  
int? fertilizerLevel;
List<String> tankLevels = [];
  String currentWord = "";
  int wordCount = 0;

class tankMonitor extends StatefulWidget {
  const tankMonitor({super.key});

  @override
  State<tankMonitor> createState() => _tankMonitorState();
}

class _tankMonitorState extends State<tankMonitor> {

  

  @override
  void initState() {
    Timer.periodic(const Duration(minutes: 10), (timer) { 
      getWaterAndFertilizerLevel();
    });
    super.initState();
  }

  void getWaterAndFertilizerLevel() {
  btInstance.receiveData();

  if (dataReceived != null) {
    List<String> tankLevels = dataReceived!.split(',');

    if (tankLevels.length >= 2) {
      int water = int.tryParse(tankLevels[0]) ?? 0;
      int fertilizer = int.tryParse(tankLevels[1]) ?? 0;

      setState(() {
        waterLevel = water.clamp(0, 100); // Ensure water level is between 0 and 100
        fertilizerLevel = fertilizer.clamp(0, 100); // Ensure fertilizer level is between 0 and 100
      });

      changeValues(waterLevel!, fertilizerLevel!);
    }
  }
}

void changeValues(int water, int fertilizer) {
  // No need to check and clamp levels here, as it's already done in getWaterAndFertilizerLevel()
  setState(() {
    waterLevel = water;
    fertilizerLevel = fertilizer;
  });
}


  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Card(
          elevation: 10,
          color: Colors.blue,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tank Monitoring',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          fontFamily: "Rokkitt"),
                    ),

                    IconButton(onPressed: (){ getWaterAndFertilizerLevel(); }, icon: const Icon(Icons.refresh), color: Colors.white,)
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white70,
                        height: 300,
                        width: 360,
                        child: MyBarChart(waterLevel: waterLevel, fertilizerLevel: fertilizerLevel),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBarChart extends StatelessWidget {

  final int? waterLevel;
  final int? fertilizerLevel;
  const MyBarChart({super.key, required this.waterLevel, required this.fertilizerLevel});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: true),
          alignment: BarChartAlignment.spaceAround,
          maxY: 120),
    );
  }
}

BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (BarChartGroupData group) => Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (BarChartGroupData group, int groupIndex,
            BarChartRodData rod, int rodIndex) {
          return BarTooltipItem(
            "${rod.toY.toString()}%",
            const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          );
        }));

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Water Level';
      break;
    case 1:
      text = 'Fertilizer Level';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(
      text,
      style: style,
    ),
  );
}

FlTitlesData get titlesData => const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true, reservedSize: 30, getTitlesWidget: getTitles),
      ),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
    );

FlBorderData get borderData => FlBorderData(
      show: false,
    );

LinearGradient get _barsGradiant => const LinearGradient(
      colors: [
        Colors.redAccent,
        Colors.blueAccent,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

List<BarChartGroupData> get barGroups => [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: waterLevel != null ? waterLevel!.toDouble() : 0.0,
              gradient: _barsGradiant,
              width: 20,
              borderRadius: BorderRadius.circular(4))
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: fertilizerLevel != null ? fertilizerLevel!.toDouble() : 0.0,
              gradient: _barsGradiant,
              width: 20,
              borderRadius: BorderRadius.circular(4))
        ],
        showingTooltipIndicators: [0],
      ),
    ];

class BarChartIrrig extends StatefulWidget {
  const BarChartIrrig({super.key});

  @override
  State<BarChartIrrig> createState() => _BarChartIrrigState();
}

class _BarChartIrrigState extends State<BarChartIrrig> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1.6, child: MyBarChart(waterLevel: waterLevel, fertilizerLevel: fertilizerLevel));
  }
}
