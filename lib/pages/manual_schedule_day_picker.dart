import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';

class DayPicker extends StatelessWidget {
  const DayPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DayInWeek> days = [
      DayInWeek("Mon", dayKey: "monday"),
      DayInWeek("Tue", dayKey: "tuesday"),
      DayInWeek("Wed", dayKey: "wednesday"),
      DayInWeek("Thu", dayKey: "thursday"),
      DayInWeek("Fri", dayKey: "friday"),
      DayInWeek("Sat", dayKey: "saturday"),
      DayInWeek("Sun", dayKey: "sunday")
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SelectWeekDays(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        days: days,
        border: true,
        boxDecoration: const BoxDecoration(
          color: Colors.blue,
        ),
        onSelect: (values) {
          print(values);
        },
      ),
    );
  }
}
