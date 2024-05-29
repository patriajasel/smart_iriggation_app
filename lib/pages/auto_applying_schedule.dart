import 'package:isar/isar.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

void concatenateData(int nodeNumber, String cropName, IsarLinks<Stages> stages,
    Database schedDatabase, List<Weeks> week) {
  List<Stages> stage = [];
  stage.addAll(stages);
  List<Weeks> weeks = week;
  List<String> weeksInString = [];
  const String commandType = "Automated";
  const String status = "In progress";

  for (int i = 0; i < weeks.length; i++) {
    weeksInString.add(weeks[i].waterAmount);
  }

  addAutomatedSchedule(weeksInString, commandType, status);
  /*int waterAmount = getWaterAmount(weeks[i].waterAmount);
    int scheduleID = int.parse("${sched.year}${sched.hour}${sched.minute}");*/
}

void addAutomatedSchedule(
    List<String> waterAmount, String commandType, String status) {
  List<int> parts = [];
  for (int i = 0; i < waterAmount.length; i++) {
    parts.add(getNumberAfterDash(waterAmount[i]));
  }

  for (int i = 0; i < parts.length; i++) {
    if (parts[i] <= 300) {}
  }
}

int getNumberAfterDash(String range) {
  List<String> parts = range.split('-');

  int number = int.parse(parts[1]);
  return number;
}
