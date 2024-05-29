import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'package:smart_iriggation_app/pages/dash_node_monitor_page.dart';

class nodesListView extends StatefulWidget {
  const nodesListView({super.key});

  @override
  State<nodesListView> createState() => _NodesListViewState();
}

class _NodesListViewState extends State<nodesListView> {
  @override
  void initState() {
    super.initState();
    readCropList();
  }

  void readCropList() {
    context.read<Database>().getNodes();
  }

  @override
  Widget build(BuildContext context) {
    final nodeDatabase = context.watch<Database>();

    List<Nodes> nodeList = nodeDatabase.currentNodes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          elevation: 10,
          color: Colors.blue,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Node Monitoring',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: "Rokkitt",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 400, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: nodeList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => nodeMonitorPage(
                                nodeNumber: index + 1,
                                plantType: nodeList[index].plant,
                                soilType: nodeList[index].soilType,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 4, // Add elevation for a shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Rounded corners for the card
                            side: const BorderSide(
                                color: Colors.cyan,
                                width: 2), // Border color and width
                          ),
                          child: ListTile(
                            title: Text(
                              "Plant: ${nodeList[index].plant}",
                              style: const TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Node Number: ${index + 1}",
                              style: const TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
