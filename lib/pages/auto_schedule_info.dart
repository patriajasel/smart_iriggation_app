import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

class schedInformation extends StatefulWidget {
  final String croName;
  final String cropDescription;
  final String directory;
  final IsarLinks<Stages> stages;
  const schedInformation(
      {super.key,
      required this.croName,
      required this.cropDescription,
      required this.directory,
      required this.stages});

  @override
  State<schedInformation> createState() => _schedInformationState();
}

class _schedInformationState extends State<schedInformation> {
  @override
  Widget build(BuildContext context) {
    final List<Stages> stages = [];
    stages.addAll(widget.stages);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "Crop Information",
          style: TextStyle(
            fontFamily: "Rokkitt",
          ),
        ),
      ),
      body: Column(children: [
        Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(widget.directory),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.croName,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Rokkitt",
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Divider(),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              width: double.infinity,
              child: const Text(
                "Crop Description: ",
                style: TextStyle(
                  fontFamily: "Rokkitt",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                widget.cropDescription,
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Divider(),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Crop Schedule:",
                style: TextStyle(
                  fontFamily: "Rokkitt",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: stages.length,
              itemBuilder: (BuildContext context, int index) {
                return getWeeks(stages[index].period, stages[index].weeks);
              }),
        )
      ]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/applySched');
            print('Apply Schedule button pressed');
          },
          child: const Text(
            'Apply Schedule',
            style: TextStyle(fontFamily: "Rokkitt", color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget? getWeeks(String stage, IsarLinks<Weeks> weeks) {
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
  }
}
