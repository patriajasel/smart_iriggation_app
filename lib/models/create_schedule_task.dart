import 'package:flutter/material.dart';
import 'package:schedulers/schedulers.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/command_handler.dart';
import 'package:smart_iriggation_app/models/data/water_amount.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

late Schedule sched;
bluetooth_conn btInstance = bluetooth_conn();
bool isFirstScheduleSet = false;
WaterAmountProvider provider = WaterAmountProvider();

void getTheSchedule(
    Database firstSched, Database deleteSched, BuildContext context) {
  try {
    sched = firstSched.firstSchedule[0];
    print("Adding Schedule Success");

    setSchedule(sched, deleteSched, context);
  } on RangeError {
    print("There are no schedule at the moment");
  }
}

void setSchedule(Schedule sched, Database deleteSched, BuildContext context) {
  final scheduler = TimeScheduler();

  if (DateTime.now().toUtc().isAfter(sched.timeDate)) {
    deleteSched
        .deleteSchedule(sched.id)
        .whenComplete(() => print("Schedule Deleted"));
    isFirstScheduleSet = false;
  }

  if (isFirstScheduleSet == false) {
    if (DateTime.now().toUtc().isBefore(sched.timeDate)) {
      Duration secondsToIrrigate = Duration(
          seconds: provider.waterAmount[sched.waterAmount]?['1Node'] ?? 5);

      scheduler.run(
          () => {
                btInstance.sendData(
                    "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${getArdPin(sched.nodeNum + 3)},on,",
                    context)
              },
          sched.timeDate);

      scheduler.run(
          () => {
                btInstance.sendData(
                    "${sched.commandType},${getArdPin(1)}${getArdPin(2)}${getArdPin(sched.nodeNum + 3)},off,",
                    context)
              },
          sched.timeDate.add(secondsToIrrigate));
      isFirstScheduleSet = true;
      print("Schedule was set");
    }
  } else {
    return;
  }
}
