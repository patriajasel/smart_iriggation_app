import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'package:smart_iriggation_app/pages/auto_schedule_info.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';

class cropListView extends StatefulWidget {
  const cropListView({super.key});

  @override
  State<cropListView> createState() => _cropListViewState();
}

class _cropListViewState extends State<cropListView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCropList();
  }

  void readCropList() {
    context.read<Database>().getCropsBasedSoil(/*dataReceived!*/ "Loam");
  }

  @override
  Widget build(BuildContext context) {
    final cropDatabase = context.watch<Database>();

    List<CropInformation> cropList = cropDatabase.CropInfo;

    /*return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.blue,
                margin: const EdgeInsets.all(30.0),
                width: double.infinity,
                child: Center(
                  child: Text(
                    //dataReceived!,
                    "Loam",
                    style: const TextStyle(
                      fontFamily: "Rakkas",
                      fontSize: 80,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                "Soil Type",
                style: TextStyle(
                  fontFamily: "Rokkitt",
                  fontSize: 30,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2.0,
                color: Colors.white,
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Suggested Crop List",
                    style: TextStyle(
                      fontFamily: "Rokkitt",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 10), // Add some space between text and list
              Expanded(
                child: ListView.builder(
                  itemCount: cropList.length, // Example: 5 cards
                  itemBuilder: (BuildContext context, int index) {
                    final cropName = cropList[index].cropName;
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.cyan, width: 2.0),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.local_florist),
                        title: Text(
                          cropName,
                          style: const TextStyle(
                            fontFamily: "Rokkitt",
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        subtitle: const Text(
                          'Click to view the schedule',
                          style: TextStyle(
                            fontFamily: "PatuaOne",
                          ),
                        ),
                        onTap: () {
                          context.read<Database>().getSpecificCrop(cropName);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => schedInformation(
                                        croName: cropList[index].cropName,
                                        cropDescription:
                                            cropList[index].cropDescription,
                                        directory: cropList[index].pictureDir,
                                        stages: cropList[index].stages,
                                      )));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );*/

    return Scaffold(
      body: Container(
        //color: Colors.blue,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: const Text(
                "Soil Identifier",
                style: TextStyle(
                    fontFamily: "Rokkitt", fontSize: 40.0, color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: const ListTile(
                leading: Icon(
                  Icons.eco, // Choose the appropriate ic n
                  size: 30.0, // Adjust the size if needed
                  color: Colors.green, // Uncomment and choose a color if needed
                ),
                title: Text(
                  "Type of Soil:",
                  style: TextStyle(
                      fontFamily: "Rokkitt",
                      fontSize: 25.0,
                      color: Colors.black),
                ),
                trailing: Text(
                  "Loam",
                  style: TextStyle(
                      fontFamily: "Rokkitt",
                      fontSize: 25.0,
                      color: Colors.black),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.blue,
                thickness: 4.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Below are the suggested crops that are fitted to your soil.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Rokkitt",
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Card(
              elevation: 8,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: cropList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final cropName = cropList[index].cropName;
                        return Card(
                          color: Colors.white,
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                                color: Colors.cyan, width: 2.0),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.local_florist,
                              color: Colors.green,
                            ),
                            title: Text(
                              cropName,
                              style: const TextStyle(
                                fontFamily: "Rokkitt",
                                fontSize: 20.0,
                                shadows: [
                                  Shadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: const Text(
                              'Click to view the schedule',
                              style: TextStyle(
                                fontFamily: "PatuaOne",
                              ),
                            ),
                            onTap: () {
                              context
                                  .read<Database>()
                                  .getSpecificCrop(cropName);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => schedInformation(
                                    croName: cropList[index].cropName,
                                    cropDescription:
                                        cropList[index].cropDescription,
                                    directory: cropList[index].pictureDir,
                                    stages: cropList[index].stages,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    dataReceived = null;
                    Navigator.popUntil(context, (route) {
                      return route.isFirst;
                    });
                  });
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
