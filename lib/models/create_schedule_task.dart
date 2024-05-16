import 'package:schedulers/schedulers.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

late Schedule sched;
bluetooth_conn btInstance = bluetooth_conn();
bool isFirstScheduleSet = false;

void getTheSchedule(Database firstSched, Database deleteSched) {
  try {
    sched = firstSched.firstSchedule[0];
    print("Adding Schedule Success");

    setSchedule(sched, deleteSched);
  } on RangeError {
    print("There are no schedule at the moment");
  }
}

void setSchedule(Schedule sched, Database deleteSched) {
  final scheduler = TimeScheduler();

  if (DateTime.now().toUtc().isAfter(sched.timeDate)) {
    deleteSched
        .deleteSchedule(sched.id)
        .whenComplete(() => print("Schedule Deleted"));
    isFirstScheduleSet = false;
  }

  if (isFirstScheduleSet == false) {
    if (DateTime.now().toUtc().isBefore(sched.timeDate)) {
      scheduler.run(
          () => {btInstance.sendData("Andar ka na ")}, sched.timeDate);
      scheduler.run(() => {btInstance.sendData("Stop ka na")},
          sched.timeDate.add(const Duration(seconds: 5)));
      isFirstScheduleSet = true;
      print("Schedule was set");
    }
  } else {
    return;
  }
}
