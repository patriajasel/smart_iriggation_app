import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3, milliseconds: 50), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyDashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("lib/assets/animations/water_droplet.json",
                height: 300, width: 300, fit: BoxFit.fill),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: const Text(
                "Smart Irrigation App",
                style: TextStyle(
                  fontFamily: "PatuaOne",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate()
                  .fadeIn(duration: 3.seconds + 50.milliseconds)
                  .then(delay: 1.seconds))
        ],
      ),
    );
  }
}
