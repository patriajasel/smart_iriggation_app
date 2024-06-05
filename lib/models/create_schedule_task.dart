import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulers/schedulers.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/command_handler.dart';
import 'package:smart_iriggation_app/models/data/water_amount.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

late Schedule sched;
bluetooth_conn btInstance = bluetooth_conn();
bool isFirstScheduleSet = false;
bool isScheduleSent = false;
WaterAmountProvider provider = WaterAmountProvider();
late DateTime firstSchedTime;
final scheduler = TimeScheduler();

List<Schedule> schedulesToSet = [];
List<Schedule> schedulesWithSameTime = [];

void getFirstSchedTime(
    Database firstSched, Database deleteSched, BuildContext context) {
  try {
    if (firstSched.firstSchedule.isNotEmpty) {
      sched = firstSched.firstSchedule[0];
      firstSchedTime = sched.timeDate;

      context.read<Database>().getSchedulesWithSameTime(firstSchedTime);

      if (firstSched.schedulesToSet.length == 1 && !isScheduleSent) {
        schedulesToSet.clear(); // Clear existing schedules
        schedulesToSet.addAll(firstSched.schedulesToSet);
        settingTheSchedule(schedulesToSet, deleteSched, context);
        schedulesWithSameTime.clear(); // Clear the list to avoid duplication
      } else if (firstSched.schedulesToSet.length > 1 && !isScheduleSent) {
        schedulesToSet.clear();
        schedulesWithSameTime.clear();
        schedulesWithSameTime.addAll(firstSched.schedulesToSet);
        settingTheSchedule(schedulesWithSameTime, deleteSched, context);
      }
    } else {
      print("There are no schedules at the moment");
    }
  } on RangeError {
    print("There are no schedules at the moment");
  }
}

void settingTheSchedule(
    List<Schedule> schedules, Database deleteSched, BuildContext context) {
  List<int> nodesList = [];
  List<int> durationsPerNode = [];

  print(schedules.length);

  for (int i = 0; i < schedules.length; i++) {
    nodesList.add(getArdPin(schedules[i].nodeNum + 3));
    switch (schedules.length) {
      case 1:
        durationsPerNode
            .add(provider.waterAmount[schedules[i].waterAmount]?['1Node'] ?? 5);
        break;
      case 2:
        durationsPerNode
            .add(provider.waterAmount[schedules[i].waterAmount]?['2Node'] ?? 5);
        break;
      case 3:
        durationsPerNode
            .add(provider.waterAmount[schedules[i].waterAmount]?['3Node'] ?? 5);
        break;
      case 4:
        durationsPerNode
            .add(provider.waterAmount[schedules[i].waterAmount]?['4Node'] ?? 5);
        break;
      default:
        break;
    }
    durationsPerNode
        .add(provider.waterAmount[schedules[i].waterAmount]?['1Node'] ?? 5);
  }

  print(nodesList);

  if (schedules.length == 1) {
    if (DateTime.now().toUtc().isAfter(sched.timeDate)) {
      deleteSched
          .deleteSchedule(sched.id)
          .whenComplete(() => print("Schedule Deleted"));
      isFirstScheduleSet = false;
    }
    print(isFirstScheduleSet);
    if (isFirstScheduleSet == false) {
      print("Isa lang");
      if (DateTime.now().toUtc().isBefore(sched.timeDate)) {
        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]},on,",
                      context)
                },
            sched.timeDate);

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]},off,",
                      context)
                },
            sched.timeDate.add(Duration(seconds: durationsPerNode[0])));
        isFirstScheduleSet = true;
      }
    } else {
      return;
    }
  } else if (schedules.length == 2) {
    for (int i = 0; i < schedules.length; i++) {
      if (DateTime.now().toUtc().isAfter(schedules[i].timeDate)) {
        deleteSched
            .deleteSchedule(schedules[i].id)
            .whenComplete(() => print("Schedule Deleted"));
        isFirstScheduleSet = false;
      }
    }
    print(isFirstScheduleSet);
    if (isFirstScheduleSet == false) {
      if (DateTime.now().toUtc().isBefore(schedules[0].timeDate) &&
          DateTime.now().toUtc().isBefore(schedules[1].timeDate)) {
        print("dalawa lang");
        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]},on,",
                      context)
                },
            schedules[0].timeDate);

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${nodesList[0]},off,", context)
                },
            schedules[0].timeDate.add(Duration(seconds: durationsPerNode[0])));

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[1]},off,",
                      context)
                },
            schedules[1].timeDate.add(Duration(seconds: durationsPerNode[1])));
        isFirstScheduleSet = true;
      }
    } else {
      return;
    }
  } else if (schedules.length == 3) {
    for (int i = 0; i < schedules.length; i++) {
      if (DateTime.now().toUtc().isAfter(schedules[i].timeDate)) {
        deleteSched
            .deleteSchedule(schedules[i].id)
            .whenComplete(() => print("Schedule Deleted"));
        isFirstScheduleSet = false;
      }
    }

    if (isFirstScheduleSet == false) {
      if (DateTime.now().toUtc().isBefore(schedules[0].timeDate) &&
          DateTime.now().toUtc().isBefore(schedules[1].timeDate) &&
          DateTime.now().toUtc().isBefore(schedules[2].timeDate)) {
        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]},on,",
                      context)
                },
            schedules[0].timeDate);

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${nodesList[0]},off,", context)
                },
            schedules[0].timeDate.add(Duration(seconds: durationsPerNode[0])));

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${nodesList[1]},off,", context)
                },
            schedules[1].timeDate.add(Duration(seconds: durationsPerNode[1])));

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[2]},off,",
                      context)
                },
            schedules[2].timeDate.add(Duration(seconds: durationsPerNode[2])));
        isFirstScheduleSet = true;
      }
    } else {
      return;
    }
  } else if (schedules.length == 4) {
    for (int i = 0; i < schedules.length; i++) {
      if (DateTime.now().toUtc().isAfter(schedules[i].timeDate)) {
        deleteSched
            .deleteSchedule(schedules[i].id)
            .whenComplete(() => print("Schedule Deleted"));
        isFirstScheduleSet = false;
      }
    }

    if (isFirstScheduleSet == false) {
      if (DateTime.now().toUtc().isBefore(schedules[0].timeDate) &&
          DateTime.now().toUtc().isBefore(schedules[1].timeDate) &&
          DateTime.now().toUtc().isBefore(schedules[2].timeDate) &&
          DateTime.now().toUtc().isBefore(schedules[3].timeDate)) {
        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
                      context)
                },
            schedules[0].timeDate);

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${nodesList[0]},off,", context)
                },
            schedules[0].timeDate.add(Duration(seconds: durationsPerNode[0])));

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${nodesList[1]},off,", context)
                },
            schedules[1].timeDate.add(Duration(seconds: durationsPerNode[1])));

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${nodesList[2]},off,", context)
                },
            schedules[2].timeDate.add(Duration(seconds: durationsPerNode[2])));

        scheduler.run(
            () => {
                  btInstance.sendData(
                      "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[3]},off,",
                      context)
                },
            schedules[3].timeDate.add(Duration(seconds: durationsPerNode[3])));
        isFirstScheduleSet = true;
      }
    } else {
      return;
    }
  }
}
