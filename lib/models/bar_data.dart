import 'indiv_bar.dart';

class BarData {
  final double waterLevel;
  final double fertilizerLevel;

  BarData({
    required this.waterLevel,
    required this.fertilizerLevel,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: waterLevel),
      IndividualBar(x: 1, y: fertilizerLevel)
    ];
  }
}
