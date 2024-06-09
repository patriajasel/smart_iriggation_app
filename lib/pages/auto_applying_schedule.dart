import 'package:isar/isar.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

List<List<int>> waterParts = [];
List<List<List<DateTime>>> schedDate = [[]];
List<int> parts = [];

void concatenateData(int nodeNumber, String cropName, IsarLinks<Stages> stages,
    Database schedDatabase, List<Weeks> week) {
  List<Stages> stage = [];
  stage.addAll(stages);
  List<Weeks> weeks = week;
  List<String> weeksInString = [];
  const String commandType = "Scheduled";
  const String status = "In progress";

  for (int i = 0; i < weeks.length; i++) {
    weeksInString.add(weeks[i].waterAmount);
  }
  schedDate.clear();
  waterParts.clear();
  parts.clear();
  arrangeWaterAmount(weeksInString);
  getDatePerWaterAmount(waterParts);
  addAutomatedSchedule(schedDatabase, nodeNumber, commandType, status,
      waterParts, schedDate, cropName, parts);
}

void arrangeWaterAmount(List<String> waterAmount) {
  for (int i = 0; i < waterAmount.length; i++) {
    parts.add(getNumberAfterDash(waterAmount[i]));
  }

  for (int i = 0; i < parts.length; i++) {
    if (parts[i] <= 300) {
      separateWater(parts[i], 2, 50);
    } else if (parts[i] >= 350) {
      separateWater(parts[i], 3, 50);
    }
  }
}

int getNumberAfterDash(String range) {
  List<String> parts = range.split('-');

  int number = int.parse(parts[1]);
  return number;
}

void separateWater(int water, int parts, int roundingFactor) {
  List<int> partsList = [];
  int divisible = water % (parts * roundingFactor);

  if (divisible == 0) {
    for (int i = 0; i < parts; i++) {
      int part = ((water / parts) / roundingFactor).round() * roundingFactor;
      partsList.add(part);
    }
  } else {
    if (parts == 2) {
      int part = ((water / parts) / roundingFactor).round() * roundingFactor;
      partsList.add(part);
      partsList.add(water - part);
    } else if (parts == 3) {
      int part = ((water / parts) / roundingFactor).round() * roundingFactor;
      partsList.add(part);
      partsList.add(part);
      partsList.add(water - (part * 2));
    }
  }

  // Add the partsList to waterParts
  waterParts.add(partsList);
}

void getDatePerWaterAmount(List<List<int>> waterParts) {
  DateTime baseTime = DateTime.now().add(const Duration(minutes: 3));

  for (int i = 0; i < waterParts.length; i++) {
    List<List<DateTime>> scheds = [];

    if (waterParts[i].length == 2) {
      for (int j = 0; j < 7; j++) {
        List<DateTime> sched = [];
        for (int k = 0; k < waterParts[i].length; k++) {
          if(k == 0){
            sched.add(baseTime);
          }
          else {
            baseTime = baseTime.add(const Duration(hours: 12));
          sched.add(baseTime);
          }
          
        }
        scheds.add(sched);
      }
      schedDate.add(scheds);
    } else if (waterParts[i].length == 3) {
      for (int j = 0; j < 7; j++) {
        List<DateTime> sched = [];
        for (int k = 0; k < waterParts[i].length; k++) {
          baseTime = baseTime.add(const Duration(hours: 8));
          sched.add(baseTime);
        }
        scheds.add(sched);
      }
      schedDate.add(scheds);
    }
  }
}

DateTime getNearestHour(DateTime dateTime) {
  dateTime = dateTime.add(const Duration(hours: 1));
  return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour);
}

void addAutomatedSchedule(
    Database schedDatabase,
    int nodeNumber,
    String commandType,
    String status,
    List<List<int>> waterParts,
    List<List<List<DateTime>>> schedDate,
    String cropName,
    List<int> parts) {
  for (int i = 0; i < schedDate.length; i++) {
    for (int j = 0; j < schedDate[i].length; j++) {
      for (int k = 0; k < schedDate[i][j].length; k++) {
        int scheduleID = int.parse(
            "${schedDate[i][j][k].year}${schedDate[i][j][k].hour}${schedDate[i][j][k].minute}");

        schedDatabase.addAutomatedSchedule(
            nodeNumber,
            commandType,
            scheduleID,
            status,
            schedDate[i][j][k],
            waterParts[i][k],
            i + 1,
            j + 1,
            cropName);
      }
    }
  }

  schedDatabase.updateNode(nodeNumber, cropName, "Loam", parts);
}
