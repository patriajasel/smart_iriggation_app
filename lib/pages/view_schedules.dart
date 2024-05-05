import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/notifications.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'package:workmanager/workmanager.dart';

class ViewSchedule extends StatefulWidget {
  const ViewSchedule({super.key});

  @override
  State<ViewSchedule> createState() => _ViewScheduleState();
}

class _ViewScheduleState extends State<ViewSchedule> {
  @override
  void initState() {
    super.initState();

    readSchedules();
  }

  void readSchedules() {
    context.read<Database>().getSchedule();
  }

  void deleteSchedules(int id) {
    context.read<Database>().deleteSchedule(id);

    print(id);
  }

  void getPlantType(int nodeNumber) {
    context.read<Database>().getSpecificNode(nodeNumber);
  }

  @override
  Widget build(BuildContext context) {
    final schedulesDatabase = context.watch<Database>();
    final nodesDatabase = context.watch<Database>();

    List<Schedule> listSchedules = schedulesDatabase.currentSchedule;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "View Schedules",
          style: TextStyle(
            fontFamily: "Rokkitt",
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listSchedules.length, // Number of cards
        itemBuilder: (BuildContext context, int index) {
          final dbIndex = listSchedules[index].id;
          final dbSchedID = listSchedules[index].scheduleID;
          final dbTime = listSchedules[index].timeDate;
          final dbAmount = listSchedules[index].waterAmount;
          final dbNode = listSchedules[index].nodeNum;

          getPlantType(dbNode);

          List<Nodes> plantType = nodesDatabase.specificNode;

          String? plant;

          if (plantType.isNotEmpty) {
            plant = plantType[0].plant;
          }

          String formattedTime = DateFormat('h:mm a').format(dbTime);
          String formattedDate = DateFormat('MMMM d - EEEE').format(dbTime);

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                extentRatio: 1 / 5,
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      setState(() {
                        deleteSchedules(dbIndex);
                        Notify().cancelSchedule(dbSchedID);
                        Notify().cancelSchedule(int.parse("${dbSchedID}10"));
                        Workmanager().cancelByUniqueName("TurnOn$dbSchedID");
                        Workmanager().cancelByUniqueName("TurnOff$dbSchedID");
                      });
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.alarm, size: 40.0, color: Colors.green),
                    Column(
                      children: [
                        Text(
                          formattedTime,
                          style: const TextStyle(
                              fontFamily: "Stint",
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                              fontFamily: "Stint",
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 8.0), // Spacing between title and subtitle
                    Text(
                      'Node #: $dbNode \nPlant type: $plant \n$dbAmount (mL)',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Rokkitt",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
