import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:smart_iriggation_app/models/bluetooth_conn.dart';
import 'package:smart_iriggation_app/models/command_handler.dart';

class bluetoothConnection extends StatefulWidget {
  const bluetoothConnection({super.key});

  @override
  State<bluetoothConnection> createState() => _bluetoothConnectionState();
}

class _bluetoothConnectionState extends State<bluetoothConnection> {
  bluetooth_conn btInstance = bluetooth_conn();
  BluetoothDevice? connectedDevice;

  final String commandType = "Manual";

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
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: SwitchListTile(
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
          )),
    );
  }

  Widget devicesInfo() {
    return ListTile(
      title: Text(
        "Connected to: ${connection != null ? "HC-05" : "None"}",
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
                  command = "$commandType,${getArdPin(1)},${getCommand(1)},";
                  isPumpOpen = value;
                  btInstance.sendData(command!, context);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Water Valve",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isWaterValveOpen,
              onChanged: (bool value) {
                setState(() {
                  command = "$commandType,${getArdPin(2)},${getCommand(2)},";
                  isWaterValveOpen = value;
                  btInstance.sendData(command!, context);
                  command = null;
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Fertilizer Valve",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isFertilizerValveOpen,
              onChanged: (bool value) {
                setState(() {
                  command = "$commandType,${getArdPin(3)},${getCommand(3)},";
                  isFertilizerValveOpen = value;
                  btInstance.sendData(command!, context);
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
                  command = "$commandType,${getArdPin(4)},${getCommand(4)},";
                  isNode1Open = value;
                  btInstance.sendData(command!, context);
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
                  command = "$commandType,${getArdPin(5)},${getCommand(5)},";
                  isNode2Open = value;
                  btInstance.sendData(command!, context);
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
                  command = "$commandType,${getArdPin(6)},${getCommand(6)},";
                  isNode3Open = value;
                  btInstance.sendData(command!, context);
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
                  command = "$commandType,${getArdPin(7)},${getCommand(7)},";
                  isNode4Open = value;
                  btInstance.sendData(command!, context);
                });
              }),
        ),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: SwitchListTile(
              title: const Text(
                "Mixer",
                style: TextStyle(fontFamily: "Rokkitt", fontSize: 18),
              ),
              value: isMixerOpen,
              onChanged: (bool value) {
                setState(() {
                  command = "$commandType,${getArdPin(8)},${getCommand(8)},";
                  isNode4Open = value;
                  btInstance.sendData(command!, context);
                });
              }),
        )
      ],
    );
  }
}
