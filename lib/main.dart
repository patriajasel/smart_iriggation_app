import 'package:flutter/material.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'package:smart_iriggation_app/pages/bluetooth_conn.dart';
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
  bluetooth_conn btInstance = bluetooth_conn();
  List<CropInformation> cropData = [];

  @override
  void initState() {
    super.initState();
    btInstance.requestPermission();
    btInstance.bluetoothStateListener();
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
