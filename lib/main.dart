import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'models/database.dart';
import 'pages/auto_crop_list.dart';
import 'pages/load_apply_sched_screen.dart';
import 'pages/load_soil_identify_screen.dart';
import 'pages/manual_bluetooth_conn.dart';
import 'pages/manual_schedule.dart';
import 'pages/splash_screen.dart';
import 'pages/view_schedules.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

bluetooth_conn btInstance = bluetooth_conn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  Notify().initNotification();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  //await initializeService();

  await Workmanager().initialize(
    callbackDispatcher,
  );

  btInstance.requestPermission();
  btInstance.bluetoothStateListener();

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

class _MainState extends State<Main> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
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
