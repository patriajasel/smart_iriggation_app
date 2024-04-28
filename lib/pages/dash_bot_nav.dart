import 'package:flutter/material.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: Colors.blue,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () {
              // Handle 'Set Schedule' tap
              Navigator.pushNamed(context, '/manualSched');
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.white,
                  ),
                  Text(
                    "Set Schedule",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Rokkitt",
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Handle 'Check Schedule' tap
              Navigator.pushNamed(context, '/checkSched');
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  Text(
                    "Check Schedule",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Rokkitt",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
