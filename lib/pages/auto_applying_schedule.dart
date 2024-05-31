import 'package:isar/isar.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

List<List<int>> waterParts = [];
List<List<List<DateTime>>> schedDate = [[]];

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
  schedDate.clear();
  waterParts.clear();
  arrangeWaterAmount(weeksInString);
  getDatePerWaterAmount(waterParts);
  addAutomatedSchedule(schedDatabase, nodeNumber, commandType, status,
      waterParts, schedDate, cropName);
}

void arrangeWaterAmount(List<String> waterAmount) {
  List<int> parts = [];
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
  DateTime baseHour = getNearestHour(DateTime.now());

  for (int i = 0; i < waterParts.length; i++) {
    List<List<DateTime>> scheds = [];

    if (waterParts[i].length == 2) {
      for (int j = 0; j < 7; j++) {
        List<DateTime> sched = [];
        for (int k = 0; k < waterParts[i].length; k++) {
          baseHour = baseHour.add(const Duration(hours: 12));
          sched.add(baseHour);
        }
        scheds.add(sched);
      }
      schedDate.add(scheds);
    } else if (waterParts[i].length == 3) {
      for (int j = 0; j < 7; j++) {
        List<DateTime> sched = [];
        for (int k = 0; k < waterParts[i].length; k++) {
          baseHour = baseHour.add(const Duration(hours: 8));
          sched.add(baseHour);
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
    String cropName) {
  for (int i = 0; i < schedDate.length; i++) {
    for (int j = 0; j < schedDate[i].length; j++) {
      for (int k = 0; k < schedDate[i][j].length; k++) {
        int scheduleID = int.parse(
            "${schedDate[i][j][k].year}${schedDate[i][j][k].hour}${schedDate[i][j][k].minute}");
        schedDatabase.addnewAutomatedSchedule(
            nodeNumber,
            commandType,
            scheduleID,
            status,
            schedDate[i][j][k],
            waterParts[i][k],
            i + 1,
            j + 1);
      }
    }
  }

  schedDatabase.updateNode(nodeNumber, cropName, "Loam");
}
