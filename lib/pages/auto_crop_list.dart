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
    context.read<Database>().getCropsBasedSoil(soilType!);
  }

  @override
  Widget build(BuildContext context) {
    final cropDatabase = context.watch<Database>();

    List<CropInformation> cropList = cropDatabase.CropInfo;

    print(cropList);

    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  soilType!,
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
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0), // Start from right side
                        end: Offset.zero, // Slide to center
                      ).animate(CurvedAnimation(
                        parent: AnimationController(
                          vsync: this,
                          duration:
                              const Duration(seconds: 1), // Animation duration
                        )..forward(),
                        curve: Curves.easeInOut,
                      )),
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side:
                              const BorderSide(color: Colors.cyan, width: 2.0),
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
