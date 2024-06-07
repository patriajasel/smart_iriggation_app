import 'package:flutter/material.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'dash_bot_nav.dart';
import 'dash_node_monitor.dart';
import 'dash_tank_monitor.dart';

bluetooth_conn btInstance = bluetooth_conn();

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bluetooth_conn btInstance = bluetooth_conn();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white, // Background color for the AppBar
        title: const Center(
          // Center the text within the AppBar
          child: Text(
            'Smart Irrigation App',
            style: TextStyle(fontFamily: "Rokkitt", fontSize: 27.0),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/blueConnection');
            },
            icon: const Icon(Icons.bluetooth),
            tooltip: 'Connect to a Device',
          ),
        ],
        leading: const Text(""),
      ),
      body: Container(
        child: const SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                tankMonitor(),
                nodesListView(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (connection != null) {
            Navigator.pushNamed(context, '/soilIdentify');
            btInstance.sendData("Auto,Soil,", context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('You are currently not connected to Bluetooth HC-05'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        tooltip: 'Irrigate',
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(
              color: Colors.blue, width: 3.0, style: BorderStyle.solid),
        ),
        child: Icon(Icons.water_drop, color: Colors.cyanAccent.shade200),
      ),
      bottomNavigationBar: const bottomNavBar(),
    );
  }
}
