import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';

class applySchedule extends StatefulWidget {
  const applySchedule({super.key});

  @override
  State<applySchedule> createState() => _applyScheduleState();
}

class _applyScheduleState extends State<applySchedule>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MyDashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset("lib/assets/animations/water_plant.json",
                    height: 250, width: 250, fit: BoxFit.fill),
              ),
              const Text(
                "Applying Schedule",
                style: TextStyle(
                  fontFamily: "Rokkitt",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .then(delay: 200.ms)
                  .slide(duration: 1.seconds)
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
