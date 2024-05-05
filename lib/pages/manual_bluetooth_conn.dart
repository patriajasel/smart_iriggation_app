import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';

bool isNode1Open = false;
bool isNode2Open = false;
bool isNode3Open = false;
bool isNode4Open = false;
bool isPumpOpen = false;
bool isWaterValveOpen = false;
bool isFertilizerValveOpen = false;

int getArdPin(int nodeNumber) {
  switch (nodeNumber) {
    case 1:
      return 22;
    case 2:
      return 24;
    case 3:
      return 26;
    case 4:
      return 28;
    case 5:
      return 30;
    case 6:
      return 32;
    case 7:
      return 34;
    default:
      return 0;
  }
}

String getCommand(int nodeNumber) {
  if (nodeNumber == 1) {
    if (isPumpOpen == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 2) {
    if (isWaterValveOpen == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 3) {
    if (isFertilizerValveOpen == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 4) {
    if (isNode1Open == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 5) {
    if (isNode2Open == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 6) {
    if (isNode3Open == false) {
      return "on";
    } else {
      return "off";
    }
  } else if (nodeNumber == 7) {
    if (isNode4Open == false) {
      return "on";
    } else {
      return "off";
    }
  }
  // Default return statement in case none of the conditions are met
  throw ArgumentError('Invalid node number: $nodeNumber');
}

class bluetoothConnection extends StatefulWidget {
  const bluetoothConnection({super.key});

  @override
  State<bluetoothConnection> createState() => _bluetoothConnectionState();
}

class _bluetoothConnectionState extends State<bluetoothConnection> {
  bluetooth_conn btInstance = bluetooth_conn();
  BluetoothDevice? connectedDevice = deviceConnected;

  String? command;

  @override
  void initState() {
    super.initState();
    btInstance.requestPermission();

    bluetooth.state.then((state) {
      setState(() => bluetoothState = state.isEnabled);
    });

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => bluetoothState = false);
          connectedDevice = null;
          break;
        case BluetoothState.STATE_ON:
          setState(() => bluetoothState = true);
          btInstance.getDevices();
          setState(() {
            connectedDevice = deviceConnected;
          });
          break;
        // case BluetoothState.STATE_TURNING_OFF:
        //   break;
        // case BluetoothState.STATE_TURNING_ON:
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "Manual Controls",
            style: TextStyle(
              fontFamily: "Rokkitt",
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: bluetoothConfig(),
              ),
              devicesInfo(),
              const Divider(),
              manualControls()
            ],
          ),
        ));
  }

  Widget bluetoothConfig() {
    return SwitchListTile(
        value: bluetoothState,
        onChanged: (bool value) async {
          if (value) {
            await bluetooth.requestEnable();
          } else {
            await bluetooth.requestDisable();
          }
        },
        title: Text(
          bluetoothState ? "Turn Off Bluetooth" : "Turn On Bluetooth",
          style: const TextStyle(
            fontFamily: "Rokkitt",
            fontSize: 18,
          ),
        ));
  }

  Widget devicesInfo() {
    return ListTile(
      title: Text(
        "Connected to: ${connectedDevice?.name ?? "None"}",
        style: const TextStyle(
          fontFamily: "Rokkitt",
          fontSize: 18,
        ),
      ),
    );
  }

  Widget manualControls() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue,
          width: double.infinity,
          child: const Text(
            'Manual Controls',
            style: TextStyle(
              fontFamily: "Rokkitt",
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color set to white
            ),
          ),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Pump",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isPumpOpen,
              onChanged: (bool value) {
                setState(() {
                  command = "Manual,${getArdPin(1)},${getCommand(1)},";
                  isPumpOpen = value;
                  btInstance.sendData(command!);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Water Pump",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isWaterValveOpen,
              onChanged: (bool value) {
                setState(() {
                  command = "Manual,${getArdPin(2)},${getCommand(2)},";
                  isWaterValveOpen = value;
                  btInstance.sendData(command!);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Water Pump",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isFertilizerValveOpen,
              onChanged: (bool value) {
                setState(() {
                  command = "Manual,${getArdPin(3)},${getCommand(3)},";
                  isFertilizerValveOpen = value;
                  btInstance.sendData(command!);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Node #1",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isNode1Open,
              onChanged: (bool value) {
                setState(() {
                  command = "Manual,${getArdPin(4)},${getCommand(4)},";
                  isNode1Open = value;
                  btInstance.sendData(command!);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Node #2",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isNode2Open,
              onChanged: (bool value) {
                setState(() {
                  command = "Manual,${getArdPin(5)},${getCommand(5)},";
                  isNode2Open = value;
                  btInstance.sendData(command!);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Node #3",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isNode3Open,
              onChanged: (bool value) {
                setState(() {
                  command = "Manual,${getArdPin(6)},${getCommand(6)},";
                  isNode3Open = value;
                  btInstance.sendData(command!);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Node #4",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isNode4Open,
              onChanged: (bool value) {
                setState(() {
                  command = "Manual,${getArdPin(7)},${getCommand(7)},";
                  isNode4Open = value;
                  btInstance.sendData(command!);
                  print(command);
                });
              }),
        )
      ],
    );
  }
}
