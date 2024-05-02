import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/pages/manual_schedule_node_list.dart';

class ManualScheduler extends StatefulWidget {
  const ManualScheduler({super.key});

  @override
  State<ManualScheduler> createState() => _ManualSchedulerState();
}

class _ManualSchedulerState extends State<ManualScheduler> {
  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay? selectedTime;
  late Timer _timer;
  DateTime _dateTime = DateTime.now();
  late String formattedDate = formatDate(_dateTime);

  bool _remindME = false;

  final textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());

    super.initState();
  }

  void _updateTime() {
    setState(() {
      currentTime = TimeOfDay.now();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "Set Irrigation Schedule",
          style: TextStyle(fontFamily: "Rokkitt"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // DISPLAYING CURRENT TIME AND SELECTED TIME
            Text(
              selectedTime != null
                  ? "${selectedTime!.hourOfPeriod < 10 ? '0${selectedTime!.hourOfPeriod}' : selectedTime!.hourOfPeriod} : ${selectedTime!.minute < 10 ? '0${selectedTime!.minute}' : selectedTime!.minute}  ${selectedTime!.period.toString() == "DayPeriod.am" ? 'AM' : 'PM'}"
                  : "${currentTime.hourOfPeriod < 10 ? '0${currentTime.hourOfPeriod}' : currentTime.hourOfPeriod} : ${currentTime.minute < 10 ? '0${currentTime.minute}' : currentTime.minute}  ${currentTime.period.toString() == "DayPeriod.am" ? 'AM' : 'PM'}",
              style: const TextStyle(fontFamily: "Stint", fontSize: 50.0),
            ),

            // SHOWING TIME PICKER TO PICK TIME
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                      context: context, initialTime: currentTime);

                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay.replacing(
                          hour: timeOfDay.hourOfPeriod,
                          minute: timeOfDay.minute);

                      if (currentTime.hour > selectedTime!.hour ||
                          (currentTime.hour == selectedTime!.hour &&
                              currentTime.minute > selectedTime!.minute)) {
                        _dateTime = DateTime.now().add(const Duration(days: 1));
                        formattedDate = formatDate(_dateTime);
                      } else {
                        _dateTime = DateTime.now();
                        formattedDate = formatDate(_dateTime);
                      }

                      if (timeOfDay.period == DayPeriod.am &&
                          selectedTime!.hour == 12) {
                        selectedTime = selectedTime!.replacing(hour: 0);
                      } else if (timeOfDay.period == DayPeriod.pm &&
                          selectedTime!.hour < 12) {
                        selectedTime = selectedTime!
                            .replacing(hour: selectedTime!.hour + 12);
                      }
                    });
                  }
                },
                child: const Text(
                  "Pick Time",
                  style: TextStyle(
                      fontFamily: "Rokkitt",
                      color: Colors.blue,
                      fontSize: 18.0),
                ),
              ),
            ),

            // DATE PICKER
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Card(
                  // Add your card content here
                  color: Colors.blue.shade400,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          formattedDate,
                          style: const TextStyle(
                              fontFamily: "Rokkitt",
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                              child: VerticalDivider(
                                color: Colors.white,
                                thickness: 1.0,
                                width: 10.0,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: _showDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                              label: const Text(
                                  ''), // You can put an empty Text widget or null here
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(color: Colors.white, thickness: 1.0),
                      ),

                      // SELECTING THE NODE
                      const nodeSelector(),

                      // TEXTFIELD FOR MEASUREMENTS
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Water amount (mL)",
                                style: TextStyle(
                                    fontFamily: "Rokkitt",
                                    fontSize: 18.0,
                                    color: Colors.white),
                              ),
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: textController,
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: "Rokkitt"),
                              decoration: InputDecoration(
                                hintText: 'Input water amount...',
                                hintStyle: const TextStyle(
                                    color: Colors.white70,
                                    fontFamily: "Rokkitt",
                                    fontSize: 16.0),
                                suffixIcon: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    textController.clear();
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white), // Set border color
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white), // Set border color
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, right: 8.0, left: 8.0),
                        child: Divider(color: Colors.white, thickness: 1.0),
                      ),

                      // REMIND ME
                      Theme(
                        data: ThemeData(useMaterial3: false),
                        child: SwitchListTile(
                            activeColor: Colors.blueAccent.shade700,
                            inactiveThumbColor: Colors.white70,
                            inactiveTrackColor: Colors.white,
                            activeTrackColor: Colors.white,
                            secondary: const Icon(Icons.notifications,
                                color: Colors.white),
                            title: const Text(
                              "Remind Me",
                              style: TextStyle(
                                  fontFamily: "Rokkitt",
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            value: _remindME,
                            onChanged: (bool value) {
                              setState(() {
                                _remindME = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // SAVE AND CANCEL BUTTONS
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 20.0), // Add margin to the top
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              textController.clear();
                              selectedTime = TimeOfDay.now();
                              _dateTime = DateTime.now();
                              formattedDate = formatDate(_dateTime);
                            });
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
                                DateTime(
                                    _dateTime.year,
                                    _dateTime.month,
                                    _dateTime.day,
                                    selectedTime!.hour,
                                    selectedTime!.minute),
                                int.parse(textController.text),
                                1,
                                _remindME);
                            textController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text("New schedule added"),
                              action: SnackBarAction(
                                  label: "View",
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/checkSched');
                                  }),
                            ));
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
    );
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _dateTime,
            firstDate: _dateTime,
            lastDate: DateTime(2030))
        .then((value) => setState(() {
              _dateTime = value!;
              formattedDate = formatDate(_dateTime);
            }));
  }

  String formatDate(DateTime dateTime) {
    // Format the date
    String formattedDate = DateFormat('MMMM d, yyyy - EEEE').format(dateTime);
    return formattedDate;
  }
}
