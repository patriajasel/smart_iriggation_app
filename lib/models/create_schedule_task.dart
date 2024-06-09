import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulers/schedulers.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/command_handler.dart';
import 'package:smart_iriggation_app/models/data/water_amount.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'package:smart_iriggation_app/pages/dash_node_monitor_page.dart';

bluetooth_conn btInstance = bluetooth_conn();
bool isFirstScheduleSet = false;
WaterAmountProvider provider = WaterAmountProvider();
final scheduler = TimeScheduler();

checkForMultipleSchedule(
    Schedule? firstSchedule, BuildContext context, Database firstSched) {
  if (firstSchedule != null) {
    context.read<Database>().getSchedulesWithSameTime(firstSchedule.timeDate);
    List<Schedule> schedToSet = checkSoilMoisture(firstSched.schedulesToSet, firstSched);
    List<Schedule> updateSchedulesToSet = checkSoilMoisture(schedToSet, firstSched);

    if (schedToSet.length > 1) {
      print("There are multiple Schedules");
      createMultipleSchedules(updateSchedulesToSet, context, firstSched);
    } else if (schedToSet.length == 1) {
      print("There is only on Schedule");
      createSingleSchedule(firstSchedule, firstSched, context);
    }
  }
}
List<Schedule> checkSoilMoisture(List<Schedule> scheds, Database db){
  List<Schedule> updatedSchedule = [];

  for(int i = 0; i < scheds.length; i++){
    if(scheds[i].status == "N/A"){
      updatedSchedule.add(scheds[i]);
    }
    else if(scheds[i].status == "In progress"){
      switch (scheds[i].nodeNum) {
        case 1:
          if(soilMoisture1! > 50){
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(hours: 1)), scheds[i].id);
          } else if (soilMoisture1! > 30 && soilMoisture1! < 50) {
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(minutes: 30)), scheds[i].id);
          } else {
            updatedSchedule.add(scheds[i]);
          }
          break;
        case 2:
          if(soilMoisture2! > 50){
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(hours: 1)), scheds[i].id);
          } else if (soilMoisture2! > 30 && soilMoisture2! < 50) {
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(minutes: 30)), scheds[i].id);
          } else {
            updatedSchedule.add(scheds[i]);
          }
          break;
        case 3:
          if(soilMoisture3! > 50){
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(hours: 1)), scheds[i].id);
          } else if (soilMoisture3! > 30 && soilMoisture3! < 50) {
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(minutes: 30)), scheds[i].id);
          } else {
            updatedSchedule.add(scheds[i]);
          }
          break;
        case 4:
          if(soilMoisture4! > 50){
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(hours: 1)), scheds[i].id);
          } else if (soilMoisture4! > 30 && soilMoisture4! < 50) {
            db.updateScheduleDateTime(scheds[i].timeDate.add(const Duration(minutes: 30)), scheds[i].id);
          } else {
            updatedSchedule.add(scheds[i]);
          }
          break;
        default:
      }
    }
  }
  return updatedSchedule;
}


void createSingleSchedule(
    Schedule firstSchedule, Database deleteSched, BuildContext context) {
  int? durationToIrrigate =
      provider.waterAmount[firstSchedule.waterAmount]!['1Node'];

  if (DateTime.now().toUtc().isAfter(firstSchedule.timeDate)) {

    if(firstSchedule.status == "In progress"){
      deleteSched.updateSchedule("Completed", firstSchedule.id);
    } else if(firstSchedule.status == "N/A") {
      deleteSched
        .deleteSchedule(firstSchedule.id)
        .whenComplete(() => print("Schedule Deleted"));
    
    }
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

void deleteSchedules(List<Schedule> scheds, Database db) {
  for (int i = 0; i < scheds.length; i++) {
    if(scheds[i].status == "N/A"){
      db
        .deleteSchedule(scheds[i].id)
        .whenComplete(() => print("Schedule Deleted"));
    } else if (scheds[i].status == "In progress"){
      db.updateSchedule("Completed", scheds[i].id);
    }
    
  }
  isFirstScheduleSet = false;
}

// FOR MULTIPLE SCHEDULES

void createMultipleSchedules(
    List<Schedule> schedToSet, BuildContext context, Database deleteSched) {
  List<int> nodesList = [];
  List<int> durationsPerNode = [];

  if (DateTime.now().toUtc().isAfter(schedToSet[0].timeDate)) {
   deleteSchedules(schedToSet, deleteSched);
  }

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
        durationsPerNode[1] == durationsPerNode[2]) { 
          print("3 schedules have the same amount");
      if (isFirstScheduleSet == false) {
        print("Setting the Schedule");
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          print("3 schedules with the same amount has been set ");
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
  } else if(schedToSet.length == 4){
    // IF 4 SCHEDULES HAVE THE SAME TIME
    if (durationsPerNode[0] == durationsPerNode[1] && durationsPerNode[1] == durationsPerNode[2] && durationsPerNode[2] == durationsPerNode[3] && durationsPerNode[3] == durationsPerNode[4]) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},off,",
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
    } else if (durationsPerNode[0] == durationsPerNode[1]) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[1].commandType},${nodesList[0]}${nodesList[1]},off,",
                        context)
                  },
              schedToSet[1]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[1])));
          
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[2].commandType},${nodesList[2]},off,",
                        context)
                  },
              schedToSet[2]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[3].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[3]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[3]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[3])));
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
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[1].commandType},${nodesList[0]},off,",
                        context)
                  },
              schedToSet[1]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[1])));
          
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[2].commandType},${nodesList[1]}${nodesList[2]},off,",
                        context)
                  },
              schedToSet[2]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[3].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[3]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[3]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[3])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else if (durationsPerNode[2] == durationsPerNode[3]) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[1].commandType},${nodesList[0]},off,",
                        context)
                  },
              schedToSet[1]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[1])));
          
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[2].commandType},${nodesList[1]},off,",
                        context)
                  },
              schedToSet[2]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[3].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[2]}${nodesList[3]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[3]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[3])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else if (durationsPerNode[0] == durationsPerNode[1] && durationsPerNode[2] == durationsPerNode[3] ) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[1].commandType},${nodesList[0]}${nodesList[1]},off,",
                        context)
                  },
              schedToSet[1]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[1])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[3].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[2]}${nodesList[3]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[3]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[3])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else if (durationsPerNode[0] == durationsPerNode[1] && durationsPerNode[1] == durationsPerNode[2] ) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
                        context)
                  },
              schedToSet[0].timeDate);

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[2].commandType},${nodesList[0]}${nodesList[1]}${nodesList[2]},off,",
                        context)
                  },
              schedToSet[2]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[3].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[3]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[3]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[3])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    } else if (durationsPerNode[1] == durationsPerNode[2] && durationsPerNode[2] == durationsPerNode[3] ) {
      if (isFirstScheduleSet == false) {
        if (DateTime.now().toUtc().isBefore(schedToSet[0].timeDate)) {
          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
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
                        "${schedToSet[3].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[1]}${nodesList[2]}${nodesList[3]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[3]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[3])));
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
                        "${schedToSet[0].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[0]}${nodesList[1]}${nodesList[2]}${nodesList[3]},on,",
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
                        "${schedToSet[2].commandType},${nodesList[2]},off,",
                        context)
                  },
              schedToSet[2]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[2])));

          scheduler.run(
              () => {
                    btInstance.sendData(
                        "${schedToSet[3].commandType},${getArdPin(1)}${getArdPin(2)}${nodesList[3]},off,",
                        context),
                    deleteSchedules(schedToSet, deleteSched)
                  },
              schedToSet[3]
                  .timeDate
                  .add(Duration(seconds: durationsPerNode[3])));
          isFirstScheduleSet = true;
        }
      } else {
        return;
      }
    }
  } 
}
