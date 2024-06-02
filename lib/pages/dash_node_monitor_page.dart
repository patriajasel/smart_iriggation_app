import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

class nodeMonitorPage extends StatefulWidget {
  final int nodeNumber;
  final String plantType;
  final String soilType;
  final List<int> waterPerDay;
  const nodeMonitorPage(
      {super.key,
      required this.nodeNumber,
      required this.plantType,
      required this.soilType,
      required this.waterPerDay});

  @override
  State<nodeMonitorPage> createState() => _nodeMonitorPageState();
}

class _nodeMonitorPageState extends State<nodeMonitorPage> {
  final textController = TextEditingController();
  List<int> numberOfWeeks = [];
  List<int> waterPerDay = [];
  List<int> numberOfDays = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSchedBasedOnNode(widget.nodeNumber);
    readAutomatedSchedBasedOnNode(widget.nodeNumber, widget.plantType);
  }

  void readSchedBasedOnNode(int node) {
    context.read<Database>().getScheduleBasedOnNode(node);
  }

  void readAutomatedSchedBasedOnNode(int node, String cropName) {
    context.read<Database>().getAutoScheduleByNode(node, cropName);
  }

  void deleteSchedules(int id) {
    context.read<Database>().deleteSchedule(id);
  }

  void showDialogBox(String dialogName, String hint, String what) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 190,
              width: 200,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    dialogName,
                    style:
                        const TextStyle(fontFamily: "Rokkitt", fontSize: 20.0),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            hintText: hint)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel",
                              style: TextStyle(
                                  fontFamily: "Rokkitt", fontSize: 18.0))),
                      TextButton(
                          onPressed: () {
                            if (what == "plant") {
                              context.read<Database>().updateNode(
                                  widget.nodeNumber,
                                  textController.text,
                                  widget.soilType,
                                  widget.waterPerDay);
                            } else if (what == "soil") {
                              context.read<Database>().updateNode(
                                  widget.nodeNumber,
                                  widget.plantType,
                                  textController.text,
                                  widget.waterPerDay);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Update Complete")));

                            textController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Update",
                              style: TextStyle(
                                  fontFamily: "Rokkitt", fontSize: 18.0)))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void populateWeeks(List<AutoSchedule> autoSched) {
    Set<int> numberOfWeeksSet =
        {}; // Using a Set to automatically handle duplicates

    for (var schedule in autoSched) {
      numberOfWeeksSet.add(schedule.week);
    }

    // Clear the existing list and add the unique values from the set
    numberOfWeeks.clear();
    numberOfWeeks.addAll(numberOfWeeksSet);

    // Optionally, sort the list if needed
    numberOfWeeks.sort();
  }

  void populateDays(List<AutoSchedule> autoSched) {
    Set<int> numberOfDaysSet =
        {}; // Using a Set to automatically handle duplicates

    for (var schedule in autoSched) {
      numberOfDaysSet.add(schedule.day);
    }

    // Clear the existing list and add the unique values from the set
    numberOfDays.clear();
    numberOfDays.addAll(numberOfDaysSet);

    // Optionally, sort the list if needed
    numberOfDays.sort();
  }

  @override
  Widget build(BuildContext context) {
    final nodeDatabase = context.watch<Database>();

    List<Schedule> additionalSched = nodeDatabase.currentScheduleNode;
    List<AutoSchedule> autoSched = nodeDatabase.autoSchedule;
    List<int> waterPerDay = widget.waterPerDay;

    numberOfWeeks.clear();
    populateWeeks(autoSched);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "Node Monitor",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Rokkitt"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              SingleChildScrollView(
                clipBehavior: Clip.none,
                controller: ScrollController(initialScrollOffset: 40.0),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //SOIL MOISTURE LEVEL
                    Container(
                      height: 150,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.water_drop,
                              color: Colors.blue,
                              size: 40.0,
                            ),
                          ),
                          Center(
                            child: Text(
                              "60%",
                              style: TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 25.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: Colors.blue,
                              thickness: 4.0,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Moisture Level",
                              style: TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //PLANT TYPE
                    Container(
                      height: 150,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.green,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.eco,
                                  color: Colors.green,
                                  size: 40.0,
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Colors.black,
                                  onPressed: () {
                                    showDialogBox("Update Plant Name",
                                        widget.plantType, "plant");
                                  }),
                            ],
                          ),
                          Center(
                            child: Text(
                              widget.plantType,
                              style: const TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 25.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: Colors.green,
                              thickness: 4.0,
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Plant Type",
                              style: TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //SOIL TYPE
                    Container(
                      height: 150,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.brown,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.landscape,
                                  color: Colors.brown,
                                  size: 40.0,
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Colors.black,
                                  onPressed: () {
                                    showDialogBox("Update Soil Type",
                                        widget.soilType, "soil");
                                  }),
                            ],
                          ),
                          Center(
                            child: Text(
                              widget.soilType,
                              style: const TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 25.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: Colors.brown,
                              thickness: 4.0,
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Soil Type",
                              style: TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: const Divider(
                  color: Colors.black,
                  thickness: 3.0,
                ),
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blue),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(top: 10.0),
                    child: const Column(
                      children: [
                        Text(
                          "Crop Schedules",
                          style: TextStyle(
                              fontFamily: "Rokkitt",
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  autoSched.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'This node was not applied with Automatic process by our system.',
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Rokkitt"),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Week',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Water (per Day)',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Status',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: List.generate(numberOfWeeks.length, (index) {
                            return DataRow(cells: [
                              DataCell(Text("Week: ${numberOfWeeks[index]}"),
                                  onTap: () {
                                showSchedulePerDay(
                                    context, numberOfWeeks[index]);
                              }),
                              DataCell(Text("${waterPerDay[index]} (mL)"),
                                  onTap: () {
                                showSchedulePerDay(
                                    context, numberOfWeeks[index]);
                              }),
                              DataCell(
                                const Text(
                                  "In progress",
                                  style: TextStyle(color: Colors.amber),
                                ),
                                onTap: () {
                                  showSchedulePerDay(
                                      context, numberOfWeeks[index]);
                                },
                              ),
                            ]);
                          }),
                        ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue),
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(top: 10.0),
                child: const Center(
                  child: Text(
                    "Additional Schedules",
                    style: TextStyle(
                        fontFamily: "Rokkitt",
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ),
              additionalSched.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'No additional schedules have been set.',
                          style: TextStyle(fontSize: 18, fontFamily: "Rokkitt"),
                        ),
                      ),
                    )
                  : DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Water Amount',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Action',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: List.generate(additionalSched.length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(
                              formatDate(additionalSched[index].timeDate))),
                          DataCell(Text(
                              "${additionalSched[index].waterAmount} (mL)")),
                          DataCell(
                            const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              setState(() {
                                deleteSchedules(additionalSched[index].id);
                              });
                            },
                          ),
                        ]);
                      }),
                    ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        nodeDatabase
                            .deleteAutoScheduleByNode(widget.nodeNumber);
                        nodeDatabase.deleteScheduleByNode(widget.nodeNumber);
                        nodeDatabase.updateNode(
                            widget.nodeNumber, "Empty", "Unknown", []);
                      });
                    },
                    child: const Text("Delete all Node data")),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSchedulePerDay(BuildContext context, int weekNumber) async {
    // Fetch the weekly schedule data before showing the dialog
    await context
        .read<Database>()
        .getAutoScheduleByWeek(weekNumber, widget.plantType);
    final schedDatabase = context.read<Database>();
    List<AutoSchedule> schedByWeek = schedDatabase.autoScheduleByWeek;
    populateDays(schedByWeek);

    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Schedule Per Day",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          titleTextStyle:
              const TextStyle(fontFamily: "Rokkitt", fontSize: 25.0),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: ListBody(
                children: List.generate(numberOfDays.length, (index) {
                  // Fetch data for each day synchronously
                  context.read<Database>().getAutoScheduleByDay(
                      widget.plantType, weekNumber, index + 1);
                  List<AutoSchedule> schedPerDay =
                      schedDatabase.autoScheduleByDay;

                  return ExpansionTile(
                    title: Text("Day: ${numberOfDays[index]}"),
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Water per Plant')),
                            DataColumn(label: Text('Status'))
                          ],
                          rows: List.generate(schedPerDay.length, (index) {
                            return DataRow(cells: [
                              DataCell(Text(
                                  formatDate(schedPerDay[index].timeDate))),
                              DataCell(Text(
                                  "${schedPerDay[index].waterAmount} (mL)")),
                              DataCell(
                                Text(
                                  "${schedPerDay[index].status}",
                                  style: TextStyle(
                                    color: getStatusColor(
                                        schedPerDay[index].status),
                                  ),
                                ),
                              ),
                            ]);
                          }),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'In progress':
        return Colors.amber;
      case 'Complete':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

String formatDate(DateTime dateTime) {
  // Format the date
  String formattedDate = DateFormat('EE - ').add_jm().format(dateTime);
  return formattedDate;
}

/*Widget? getWeeks(String stage, IsarLinks<Weeks> weeks) {
  List<Weeks> perWeek = weeks.toList();
  return ExpansionTile(
    title: Text(stage),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              columns: const [
                DataColumn(label: Text('Action')),
                DataColumn(label: Text('Water per Plant'))
              ],
              rows: List.generate(perWeek.length, (index) {
                return DataRow(cells: [
                  DataCell(Text(perWeek[index].week)),
                  DataCell(Text(perWeek[index].waterAmount))
                ]);
              })),
        ),
      )
    ],
  );
}*/
