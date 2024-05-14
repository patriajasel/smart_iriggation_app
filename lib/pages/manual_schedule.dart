import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/database.dart';
import 'package:smart_iriggation_app/models/notifications.dart';
import 'package:smart_iriggation_app/models/schedule.dart';
import 'package:workmanager/workmanager.dart';
import 'manual_bluetooth_conn.dart';

bluetooth_conn btInstance = bluetooth_conn();

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case 'sendDataToHC05':
        btInstance.sendData(
            "${inputData?['commandType']},${inputData?['node']},${inputData?['command']},");
        break;
      case 'Open Foreground':
        final service = FlutterBackgroundService();

        service.startService();
        FlutterBackgroundService().invoke("setAsForeGround");
        break;
      default:
        break;
    }
    return Future.value(true);
  });
}

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
  int? _selectedIndex;

  final textController = TextEditingController();

  List<String> arrangedList = [];

  @override
  void initState() {
    // TODO: implement initState
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());

    super.initState();
    readNodes();
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

                      if (currentTime.hour > timeOfDay.hour ||
                          (currentTime.hour == timeOfDay.hour &&
                              currentTime.minute > timeOfDay.minute)) {
                        _dateTime = DateTime.now().add(const Duration(days: 1));
                        formattedDate = formatDate(_dateTime);
                      } else {
                        _dateTime = DateTime.now();
                        formattedDate = formatDate(_dateTime);
                        print(currentTime);
                        print(selectedTime);
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
                                  color: Colors.white),
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
                            iconEnabledColor: Colors.white,
                          ),
                        ),
                      ),

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
                          onPressed: () async {
                            DateTime scheduledTime = DateTime(
                                _dateTime.year,
                                _dateTime.month,
                                _dateTime.day,
                                selectedTime!.hour,
                                selectedTime!.minute);

                            int notifID = int.parse(
                                "${scheduledTime.month}${scheduledTime.day}${scheduledTime.minute}${scheduledTime.second}");
                            Duration delay =
                                scheduledTime.difference(DateTime.now()).abs();
                            late Map<String, dynamic> commands;

                            setState(() {
                              context.read<Database>().addNewSchedule(
                                  notifID,
                                  scheduledTime,
                                  int.parse(textController.text),
                                  _selectedIndex!,
                                  _remindME);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text("New schedule added"),
                                action: SnackBarAction(
                                    label: "View",
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/checkSched');
                                    }),
                              ));

                              if (_remindME == true &&
                                  scheduledTime
                                          .difference(DateTime.now())
                                          .inMinutes >
                                      10) {
                                notifyMe10Mins(
                                    int.parse("${notifID}10"),
                                    "Watering Node #${_selectedIndex!} in 10 minutes. Please make sure that your bluetooth is connected to HC-05",
                                    scheduledTime
                                        .subtract(const Duration(minutes: 10)));
                              }

                              notifyTask(
                                  notifID,
                                  "Watering Node #${_selectedIndex!} now",
                                  scheduledTime);

                              commands = {
                                'commandType': 'Manual',
                                'node': getArdPin(_selectedIndex!),
                                'command': getCommand(_selectedIndex!)
                              };

                              executeTask("TurnOn${notifID}", "sendDataToHC05",
                                  delay, commands);
                            });

                            setState(() {
                              commands = {
                                'commandType': 'Manual',
                                'node': getArdPin(_selectedIndex!),
                                'command': getCommand(_selectedIndex!)
                              };

                              executeTask("TurnOff${notifID}", "sendDataToHC05",
                                  delay + const Duration(seconds: 3), commands);

                              _remindME = false;
                              _selectedItem = arrangedList[0];
                              textController.clear();
                              selectedTime = currentTime;
                              _dateTime = DateTime.now();
                              formattedDate = formatDate(_dateTime);
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

  Future<void> executeTask(String taskID, String taskName, Duration delay,
      Map<String, dynamic> inputData) async {
    Workmanager().registerOneOffTask(taskID, taskName,
        initialDelay: delay, inputData: inputData);
  }
}
