import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'models/database.dart';
import 'pages/auto_crop_list.dart';
import 'pages/load_apply_sched_screen.dart';
import 'pages/load_soil_identify_screen.dart';
import 'pages/manual_bluetooth_conn.dart';
import 'pages/manual_schedule.dart';
import 'pages/splash_screen.dart';
import 'pages/view_schedules.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Database(),
      child: const Main(),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List items = [];
  List<CropInformation> cropData = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> insertToDatabase(
      String soilType, String cropName, String pirDir, String cropDesc) async {
    context.read<Database>().addNewCrop(soilType, cropName, pirDir, cropDesc);
  }

  void insertToStages(String cropName, String stageName) {
    context.read<Database>().addNewStage(cropName, stageName);
  }

  void insertToWeeks(
      String cropName, String stageName, String week, String waterAmount) {
    context.read<Database>().addNewWeek(cropName, stageName, week, waterAmount);
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("lib/models/data/data.json");

    final data = await json.decode(response);
    setState(() {
      items = data["crops"];
      for (int i = 0; i < items.length; i++) {
        insertToDatabase(items[i]["cropSoil"], items[i]["cropName"],
            items[i]["pictureDir"], items[i]["cropDesc"]);

        for (int j = 0; j < items[i]["stages"].length; j++) {
          insertToStages(
              items[i]["cropName"], items[i]["stages"][j]["duration"]);

          for (int k = 0; k < items[i]["stages"][j]["weeks"].length; k++) {
            insertToWeeks(
                items[i]["cropName"],
                items[i]["stages"][j]["duration"],
                items[i]["stages"][j]["weeks"][k]["week"],
                items[i]["stages"][j]["weeks"][k]["waterAmount"]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/manualSched': (context) => const ManualScheduler(),
        '/checkSched': (context) => const ViewSchedule(),
        '/soilIdentify': (context) => const loadingScreen(),
        '/applySched': (context) => const applySchedule(),
        '/blueConnection': (context) => const bluetoothConnection(),
        '/cropList': (context) => const cropListView()
      },
    );
  }
}
