import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'manual_schedule_day_picker.dart';
import 'manual_schedule_node_list.dart';

class ManualScheduler extends StatefulWidget {
  const ManualScheduler({super.key});

  @override
  State<ManualScheduler> createState() => _ManualSchedulerState();
}

class _ManualSchedulerState extends State<ManualScheduler> {
  TimeOfDay selectedTime = TimeOfDay.now();

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "Manual Scheduler",
          style: TextStyle(
            fontFamily: "Rokkitt",
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "${selectedTime.hourOfPeriod < 10 ? '0${selectedTime.hourOfPeriod}' : selectedTime.hourOfPeriod} : ${selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute}  ${selectedTime.period.toString() == "DayPeriod.am" ? 'AM' : 'PM'}",
                style: const TextStyle(fontFamily: "PatuaOne", fontSize: 70.0),
              ),
              ElevatedButton(
                child: const Text(
                  "Pick Time",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime =
                          timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              const Divider(),
              const DayPicker(),
              const nodeSelector(),
              Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Measurement",
                  style: TextStyle(
                    fontFamily: "Rokkitt",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Water Amount per Plant (mL)",
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 20.0), // Add margin to the top
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your save functionality here
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Add some space between the buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<Database>().addNewSchedule(
                                  " ${selectedTime.hourOfPeriod.toString()} : ${selectedTime.minute.toString()}",
                                  int.parse(textController.text),
                                  "Mon",
                                  1);

                              textController.clear();
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
