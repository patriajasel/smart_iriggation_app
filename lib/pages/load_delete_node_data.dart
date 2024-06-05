import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';

class deletingScreen extends StatefulWidget {
  const deletingScreen({super.key});

  @override
  State<deletingScreen> createState() => _deletingScreenState();
}

class _deletingScreenState extends State<deletingScreen>
    with SingleTickerProviderStateMixin {
  bluetooth_conn btInstance = bluetooth_conn();

  @override
  void initState() {
    super.initState();

    btInstance.receiveData();

    Timer(const Duration(seconds: 5), () {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset("lib/assets/animations/delete_data.json",
                    height: 250, width: 250, fit: BoxFit.fill),
              ),
              const Text(
                "Deleting All Data",
                style: TextStyle(
                  fontFamily: "Rokkitt",
                  fontSize: 25,
                  color: Colors.white,
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
    );
  }
}
