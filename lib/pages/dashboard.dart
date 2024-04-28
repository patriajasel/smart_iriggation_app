import 'package:flutter/material.dart';
import 'dash_bot_nav.dart';
import 'dash_node_monitor.dart';
import 'dash_tank_monitor.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
          Navigator.pushNamed(context, '/soilIdentify');
        },
        tooltip: 'Irrigate',
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(
              color: Colors.blue, width: 3.0, style: BorderStyle.solid),
        ),
        child: const Icon(Icons.water_drop, color: Colors.blue),
      ),
      bottomNavigationBar: const bottomNavBar(),
    );
  }
}
