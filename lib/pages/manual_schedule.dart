import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/data/water_amount.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/notifications.dart';
import 'package:smart_iriggation_app/models/schedule.dart';

bluetooth_conn btInstance = bluetooth_conn();

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

  int? _selectedIndex;

  List<String> arrangedList = [];

  final String commandType = "Scheduled";

  int? _selectedAmount;

  @override
  void initState() {
    // TODO: implement initState
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());

    readNodes();
    final WaterAmountProvider provider = WaterAmountProvider();
    _selectedAmount = provider.waterAmount.keys.first;

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

  void readNodes() {
    context.read<Database>().getNodes();
  }

  void arrangeNodeList(List<Nodes> _nList) {
    for (int i = 0; i < _nList.length; i++) {
      String item = "Node #${_nList[i].nodeNumber} : ${_nList[i].plant}";
      if (!arrangedList.contains(item)) {
        arrangedList.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final nodesDatabase = context.watch<Database>();
    final List<Nodes> _nodes = nodesDatabase.currentNodes;

    arrangeNodeList(_nodes);

    String? _selectedItem;

    if (arrangedList.isNotEmpty) {
      _selectedItem = arrangedList[0];
    }

    final WaterAmountProvider provider = WaterAmountProvider();

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
            Card(
              color: Colors.blue.shade500,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  selectedTime != null
                      ? "${selectedTime!.hourOfPeriod < 10 ? '0${selectedTime!.hourOfPeriod}' : selectedTime!.hourOfPeriod} : ${selectedTime!.minute < 10 ? '0${selectedTime!.minute}' : selectedTime!.minute}  ${selectedTime!.period.toString() == "DayPeriod.am" ? 'AM' : 'PM'}"
                      : "${currentTime.hourOfPeriod < 10 ? '0${currentTime.hourOfPeriod}' : currentTime.hourOfPeriod} : ${currentTime.minute < 10 ? '0${currentTime.minute}' : currentTime.minute}  ${currentTime.period.toString() == "DayPeriod.am" ? 'AM' : 'PM'}",
                  style: const TextStyle(
                      fontFamily: "Stint",
                      fontSize: 45.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
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

                      if (currentTime.hour > timeOfDay.hour ||
                          (currentTime.hour == timeOfDay.hour &&
                              currentTime.minute > timeOfDay.minute)) {
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

            const Padding(
              padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
              child: Divider(color: Colors.black, thickness: 1.0),
            ),

            // DATE PICKER
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        formattedDate,
                        style: const TextStyle(
                          fontFamily: "Rokkitt",
                          fontSize: 16.0,
                          //color: Colors.white
                        ),
                      ),
                      trailing: TextButton.icon(
                        onPressed: _showDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.blue,
                        ),
                        label: const Text(
                            ''), // You can put an empty Text widget or null here
                      ),
                    ),

                    // SELECTING THE NODE
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                      child: Center(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Select a Node',
                            labelStyle: const TextStyle(
                              fontFamily: "Rokkitt",
                              fontSize: 24.0,
                              //color: Colors.white
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  //color: Colors.white
                                  ), // Set border color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  //  color: Colors.white
                                  ), // Set border color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          value: _selectedItem,
                          items: arrangedList.map((String item) {
                            return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Rokkitt",
                                      fontSize: 18.0),
                                ));
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedItem = value;
                              _selectedIndex =
                                  arrangedList.indexOf(_selectedItem!) + 1;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                          //iconEnabledColor: Colors.white,
                        ),
                      ),
                    ),

                    // DROPDOWN FOR MEASUREMENTS
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                      child: Center(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Select the amount of water (mL)',
                            labelStyle: const TextStyle(
                              fontFamily: "Rokkitt",
                              fontSize: 24.0,
                              //color: Colors.white
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  //color: Colors.white
                                  ), // Set border color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  //  color: Colors.white
                                  ), // Set border color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          value: _selectedAmount,
                          items: provider.waterAmount.keys.map((int item) {
                            return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  "${item} (mL)",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Rokkitt",
                                      fontSize: 18.0),
                                ));
                          }).toList(),
                          onChanged: (int? value) {
                            setState(() {
                              _selectedAmount = value;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                          //iconEnabledColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SAVE AND CANCEL BUTTONS
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 15.0), // Add margin to the top
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
                          onPressed: () async {
                            setState(() {
                              //CONVERTING TIMEOFDAY TO DATETIME
                              DateTime scheduledTime = DateTime(
                                _dateTime.year,
                                _dateTime.month,
                                _dateTime.day,
                                selectedTime!.hour,
                                selectedTime!.minute,
                              );

                              //CREATING THE SCHEDULE ID
                              int schedID = int.parse(
                                  "${scheduledTime.year}${scheduledTime.hour}${scheduledTime.minute}");

                              //ADDING SCHEDULE IN THE ISAR DATABASE

                              nodesDatabase.addNewSchedule(
                                  commandType,
                                  "N/A",
                                  0,
                                  _selectedIndex!,
                                  schedID,
                                  "N/A",
                                  scheduledTime,
                                  _selectedAmount!,
                                  0);

                              //SHOWING SNACK BAR
                              final snackbar = SnackBar(
                                content: const Text('New Schedule Added'),
                                duration: const Duration(seconds: 1),
                                action: SnackBarAction(
                                    label: "View",
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/checkSched');
                                    }),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);

                              //ASSIGNING NOTIFICATION
                              Duration difference =
                                  DateTime.now().difference(scheduledTime);
                              int differenceInMinutes =
                                  difference.inMinutes.abs();

                              if (differenceInMinutes > 10) {
                                notifyMe10Mins(
                                    int.parse("${schedID}10"),
                                    "Watering Node #: $_selectedIndex in 10 mins. Please open the app to connect to to Bluetooth Device.",
                                    scheduledTime
                                        .subtract(const Duration(minutes: 10)));
                              }

                              notifyTask(
                                  schedID,
                                  "Watering Node #: $_selectedIndex.",
                                  scheduledTime);

                              selectedTime = currentTime;
                            });
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

  Future<void> notifyMe10Mins(
      int taskID, String body, DateTime schedTime) async {
    Notify().scheduledNotification(taskID, body, schedTime);
  }

  Future<void> notifyTask(int taskID, String body, DateTime schedTime) async {
    Notify().scheduledNotification(taskID, body, schedTime);
  }
}
