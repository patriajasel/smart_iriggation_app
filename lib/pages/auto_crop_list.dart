import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/pages/auto_schedule_info.dart';

bluetooth_conn btInstance = bluetooth_conn();
String? soilType;

class cropListView extends StatefulWidget {
  const cropListView({super.key});

  @override
  State<cropListView> createState() => _cropListViewState();
}

class _cropListViewState extends State<cropListView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    readCropList();
  }

  void readCropList() {
    if(soilType != null){
      context.read<Database>().getCropsBasedSoil(soilType!);
    } else {
      soilType ??= "Unidentified";
    }  
  }

  @override
  Widget build(BuildContext context) {
    final cropDatabase = context.watch<Database>();
    List<CropInformation> cropList = cropDatabase.CropInfo;

    Widget buildSoilIdentifier() {
      return Column(
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
            child: ListTile(
              leading: const Icon(
                Icons.eco,
                size: 30.0,
                color: Colors.green,
              ),
              title: const Text(
                "Type of Soil:",
                style: TextStyle(
                    fontFamily: "Rokkitt", fontSize: 25.0, color: Colors.black),
              ),
              trailing: Text(
                soilType!,
                style: const TextStyle(
                    fontFamily: "Rokkitt", fontSize: 25.0, color: Colors.black),
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
        ],
      );
    }

    Widget buildUnidentifiedContent() {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Cannot Identify Soil. Please try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Rokkitt",
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/soilIdentify');
                      btInstance.sendData("Soil,", context);
                    },
                    child: const Text('Retry'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      
                      
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildCropListContent() {
      return Column(
        children: [
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
                          side:
                              const BorderSide(color: Colors.cyan, width: 2.0),
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
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildSoilIdentifier(),
                if (soilType == "Unidentified")
                  buildUnidentifiedContent()
                else
                  buildCropListContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
