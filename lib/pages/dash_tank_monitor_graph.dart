import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import 'package:smart_iriggation_app/models/bar_data.dart';

class TankLevels extends StatelessWidget {
  final List Levels;
  const TankLevels({super.key, required this.Levels});

  @override
  Widget build(BuildContext context) {
    BarData myBarData =
        BarData(waterLevel: Levels[0], fertilizerLevel: Levels[1]);

    myBarData.initializeBarData();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 40.0, top: 20.0),
      child: BarChart(
        BarChartData(
            maxY: 100,
            minY: 0,
            gridData: const FlGridData(drawVerticalLine: false),
            borderData: FlBorderData(show: true),
            backgroundColor: Colors.white,
            titlesData: const FlTitlesData(
                show: true,
                bottomTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true, getTitlesWidget: getBottomTitle),
                    drawBelowEverything: true)),
            barGroups: myBarData.barData
                .map((data) => BarChartGroupData(x: data.x, barRods: [
                      BarChartRodData(
                          toY: data.y,
                          width: 20,
                          borderRadius: BorderRadius.circular(4))
                    ]))
                .toList()),
      ),
    );
  }
}

Widget getBottomTitle(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: "Rokkitt",
    fontSize: 15,
  );

  Widget text;
  switch (value) {
    case 0:
      text = const Text("Water Level", style: style);
      break;
    case 1:
      text = const Text("Fertilizer Level", style: style);
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
