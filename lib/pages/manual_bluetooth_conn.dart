import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class bluetoothConnection extends StatefulWidget {
  const bluetoothConnection({super.key});

  @override
  State<bluetoothConnection> createState() => _bluetoothConnectionState();
}

class _bluetoothConnectionState extends State<bluetoothConnection> {
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;

  String? command;

  bool isNode1Open = false;
  bool isNode2Open = false;
  bool isNode3Open = false;
  bool isNode4Open = false;
  bool isPumpOpen = false;
  bool isWaterValveOpen = false;
  bool isFertilizerValveOpen = false;

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
    _connectToHC05();
  }

  void _connectToHC05() async {
    try {
      for (final device in _devices) {
        if (device.name == "HC-05" && device.address == "58:56:00:00:56:64") {
          _connection = await BluetoothConnection.toAddress(device.address);
          _deviceConnected = device;
          setState(() {});
          return; // Exit the loop once connected
        }
      }
      // If the loop completes without finding the device
      throw Exception("HC-05 not found in available devices");
    } catch (e) {
      // Handle the exception here
      print("Failed to connect to HC-05: $e");
      // You can perform additional error handling here
    }
  }

  void _receiveData() {
    _connection?.input?.listen(_onDataReceived).onDone(() {
      print('Disconnected by remote request');
    });
  }

  void _onDataReceived(Uint8List data) {
    // Handle received data from Arduino here
    print(String.fromCharCodes(data));
  }

  void _sendData(String data) {
    if (_connection?.isConnected ?? false) {
      _connection?.output.add(ascii.encode(data));
    }
  }

  int _getArdPin(int nodeNumber) {
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

  String _getCommand(int nodeNumber) {
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

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    super.initState();

    _requestPermission();

    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
      _getDevices();
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          _deviceConnected = null;
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          _getDevices();
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
        value: _bluetoothState,
        onChanged: (bool value) async {
          if (value) {
            await _bluetooth.requestEnable();
          } else {
            await _bluetooth.requestDisable();
          }
        },
        title: Text(
          _bluetoothState ? "Turn Off Bluetooth" : "Turn On Bluetooth",
          style: const TextStyle(
            fontFamily: "Rokkitt",
            fontSize: 18,
          ),
        ));
  }

  Widget devicesInfo() {
    return ListTile(
      title: Text(
        "Connected to:  ${_deviceConnected?.name ?? "None"}",
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
                  command = "Manual,${_getArdPin(1)},${_getCommand(1)},";
                  isPumpOpen = value;
                  _sendData(command!);
                  print(command);
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
                  command = "Manual,${_getArdPin(2)},${_getCommand(2)},";
                  isWaterValveOpen = value;
                  _sendData(command!);
                  print(command);
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
                  command = "Manual,${_getArdPin(3)},${_getCommand(3)},";
                  isFertilizerValveOpen = value;
                  _sendData(command!);
                  print(command);
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
                  command = "Manual,${_getArdPin(4)},${_getCommand(4)},";
                  isNode1Open = value;
                  _sendData(command!);
                  print(command);
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
                  command = "Manual,${_getArdPin(5)},${_getCommand(5)},";
                  isNode2Open = value;
                  _sendData(command!);
                  print(command);
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
                  command = "Manual,${_getArdPin(6)},${_getCommand(6)},";
                  isNode3Open = value;
                  _sendData(command!);
                  print(command);
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
                  command = "Manual,${_getArdPin(7)},${_getCommand(7)},";
                  isNode4Open = value;
                  _sendData(command!);
                  print(command);
                });
              }),
        )
      ],
    );
  }
}
