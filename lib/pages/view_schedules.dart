import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

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

  void deleteSchedules(BuildContext context, int id) {
    context.read<Database>().deleteSchedule(id);
  }

  void delete() {}

  @override
  Widget build(BuildContext context) {
    final schedulesDatabase = context.watch<Database>();

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
          final dbTime = listSchedules[index].time;
          final dbDay = listSchedules[index].day;
          final dbAmount = listSchedules[index].waterAmount;
          final dbNode = listSchedules[index].nodeNum;

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                extentRatio: 1 / 5,
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      deleteSchedules(context, index);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.yard, size: 40.0, color: Colors.green),
                    Text(
                      dbTime,
                      style: const TextStyle(
                          fontFamily: "Rokkitt",
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0),
                    ),
                    SizedBox(height: 8.0), // Spacing between title and subtitle
                    Text(
                      'Node #: $dbNode \nPlant type: Tomato \n$dbAmount (mL)',
                      style: TextStyle(fontSize: 16.0, fontFamily: "Rokkitt"),
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
