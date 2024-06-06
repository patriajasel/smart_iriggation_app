import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulers/schedulers.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/command_handler.dart';
import 'package:smart_iriggation_app/models/data/water_amount.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

bluetooth_conn btInstance = bluetooth_conn();
bool isFirstScheduleSet = false;
WaterAmountProvider provider = WaterAmountProvider();
final scheduler = TimeScheduler();

checkForMultipleSchedule(
    Schedule? firstSchedule, BuildContext context, Database firstSched) {
  if (firstSchedule != null) {
    context.read<Database>().getSchedulesWithSameTime(firstSchedule!.timeDate);
    List<Schedule> schedToSet = firstSched.schedulesToSet;

    if (schedToSet.length > 1) {
      print("There are multiple Schedules");
      createMultipleSchedules(schedToSet, context, firstSched);
    } else if (schedToSet.length == 1) {
      print("There is only on Schedule");
      createSingleSchedule(firstSchedule, firstSched, context);
    }
  }
}

void createSingleSchedule(
    Schedule firstSchedule, Database deleteSched, BuildContext context) {
  int? durationToIrrigate =
      provider.waterAmount[firstSchedule.waterAmount]!['1Node'];

  if (DateTime.now().toUtc().isAfter(firstSchedule.timeDate)) {
    deleteSched
        .deleteSchedule(firstSchedule.id)
        .whenComplete(() => print("Schedule Deleted"));
    isFirstScheduleSet = false;
  }

  if (isFirstScheduleSet == false) {
    if (DateTime.now().toUtc().isBefore(firstSchedule.timeDate)) {
      scheduler.run(
          () => {
                btInstance.sendData(
                    "${firstSchedule.commandType},${getArdPin(1)}${getArdPin(2)}${getArdPin(firstSchedule.nodeNum + 3)},on,",
                    context)
              },
          firstSchedule.timeDate);

      scheduler.run(
          () => {
                btInstance.sendData(
                    "${firstSchedule.commandType},${getArdPin(1)}${getArdPin(2)}${getArdPin(firstSchedule.nodeNum + 3)},off,",
                    context)
              },
          firstSchedule.timeDate.add(Duration(seconds: durationToIrrigate!)));
      isFirstScheduleSet = true;
    }
  } else {
    return;
  }
}

void deleteSchedules(List<Schedule> scheds, Database deleteSched) {
  for (int i = 0; i < scheds.length; i++) {
    deleteSched
        .deleteSchedule(scheds[i].id)
        .whenComplete(() => print("Schedule Deleted"));
  }
  isFirstScheduleSet = false;
}

// FOR MULTIPLE SCHEDULES

void createMultipleSchedules(
    List<Schedule> schedToSet, BuildContext context, Database deleteSched) {
  List<int> nodesList = [];
  List<int> durationsPerNode = [];

  for (int i = 0; i < schedToSet.length; i++) {
    nodesList.add(getArdPin(schedToSet[i].nodeNum + 3));
    switch (schedToSet.length) {
      case 1:
        durationsPerNode.add(
            provider.waterAmount[schedToSet[i].waterAmount]?['1Node'] ?? 5);
        break;
      case 2:
        durationsPerNode.add(
            provider.waterAmount[schedToSet[i].waterAmount]?['2Node'] ?? 5);
        break;
      case 3:
        durationsPerNode.add(
            provider.waterAmount[schedToSet[i].waterAmount]?['3Node'] ?? 5);
        break;
      case 4:
        durationsPerNode.add(
            provider.waterAmount[schedToSet[i].waterAmount]?['4Node'] ?? 5);
        break;
      default:
        break;
    }
  }

  if (schedToSet.length == 2) {
    // IF 2 SCHEDULES HAVE THE SAME TIME
    if (durationsPerNode[0] == durationsPerNode[1]) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[0]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[0])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${nodesList[0]},off,",
                        context)
                  },
              schedToSet[0]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[0])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[1]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[1]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[1])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    }
  } else if (schedToSet.length == 3) {
    // IF 3 SCHEDULES HAVE THE SAME TIME
    if (durationsPerNode[0] == durationsPerNode[1] &&
        durationsPerNode[0] == durationsPerNode[2]) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[0]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else if (durationsPerNode[0] == durationsPerNode[1]) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${nodesList[0]}${nodesList[1]},off,",
                        context)
                  },
              schedToSet[0]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[0])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[2]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[0]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else if (durationsPerNode[1] == durationsPerNode[2]) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${nodesList[0]},off,",
                        context)
                  },
              schedToSet[0]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[0])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[1]}${nodesList[2]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[1]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[1])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${nodesList[0]},off,",
                        context)
                  },
              schedToSet[0]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[0])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[1].commandType},${nodesList[1]},off,",
                        context)
                  },
              schedToSet[1]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[1])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[2].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[2]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[2]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    }
  }
}
