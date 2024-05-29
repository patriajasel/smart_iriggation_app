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
  const nodeMonitorPage(
      {super.key,
      required this.nodeNumber,
      required this.plantType,
      required this.soilType});

  @override
  State<nodeMonitorPage> createState() => _nodeMonitorPageState();
}

class _nodeMonitorPageState extends State<nodeMonitorPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSchedBasedOnNode(widget.nodeNumber);
  }

  void readSchedBasedOnNode(int node) {
    context.read<Database>().getScheduleBasedOnNode(node);
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
                                  widget.soilType);
                            } else if (what == "soil") {
                              context.read<Database>().updateNode(
                                  widget.nodeNumber,
                                  widget.plantType,
                                  textController.text);
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

  @override
  Widget build(BuildContext context) {
    final nodeDatabase = context.watch<Database>();

    List<Schedule> additionalSched = nodeDatabase.currentScheduleNode;

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
                                  icon: Icon(Icons.edit),
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
                                  icon: Icon(Icons.edit),
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
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Stages',
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
                          'Status',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: List.generate(10, (index) {
                      return DataRow(cells: [
                        DataCell(Text("Week: ${index + 1}")),
                        const DataCell(Text("100 (mL)")),
                        DataCell(
                          const Text(
                            "In progress",
                            style: TextStyle(color: Colors.amber),
                          ),
                          onTap: () {
                            setState(() {
                              deleteSchedules(additionalSched[index].id);
                            });
                          },
                        ),
                      ]);
                    }),
                  )
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
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Delete All Node Data")),
              )
            ],
          ),
        ),
      ),
    );
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
