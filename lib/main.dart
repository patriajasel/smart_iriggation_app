import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/create_schedule_task.dart';
import 'package:smart_iriggation_app/models/foreground.dart';
import 'package:smart_iriggation_app/models/notifications.dart';
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

  await initializeService();

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
    Timer.periodic(const Duration(seconds: 10), (timer) {
      getFirstSchedule();
      print("First Schedule fetched successfully");
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final service = FlutterBackgroundService();

    service.startService();

    if (state == AppLifecycleState.paused) {
      service.invoke('setAsForeground');
      print("App is in background");
    } else if (state == AppLifecycleState.resumed) {
      service.invoke('setAsBackground');
      print("App is in foreground");
    } else if (state == AppLifecycleState.detached) {
      service.invoke('stopService');
      print("App is detached (closed)");
    }
  }

  void getFirstSchedule() {
    if (mounted) {
      setState(() {
        context.read<Database>().getFirstSchedule();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstSched = context.watch<Database>();
    final deleteSched = context.read<Database>();

    if (firstSched.firstSchedule.isNotEmpty) {
      getTheSchedule(firstSched, deleteSched, context);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/manualSched': (context) => const ManualScheduler(),
        '/checkSched': (context) => const ViewSchedule(),
        '/soilIdentify': (context) => const loadingScreen(),
        '/applySched': (context) => const applySchedule(),
        '/blueConnection': (context) => const bluetoothConnection(),
        '/cropList': (context) => const cropListView(),
      },
    );
  }
}
