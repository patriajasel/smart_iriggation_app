import 'dart:convert';
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
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  int times = 0;

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
  }

  void _receiveData() {
    _connection?.input?.listen((event) {
      if (String.fromCharCodes(event) == "p") {
        setState(() => times = times + 1);
      }
    });
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
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: bluetoothConfig(),
            ),
            devicesInfo(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            devicesList(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            manualControls()
          ],
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
        trailing: _connection?.isConnected ?? false
            ? TextButton(
                onPressed: () async {
                  await _connection?.finish();
                  setState(() => _deviceConnected = null);
                },
                child: const Text(
                  "Disconnect",
                  style: TextStyle(fontFamily: "Rokkitt"),
                ),
              )
            : ElevatedButton(
                onPressed: _getDevices,
                child: const Text("View Paired Devices")));
  }

  Widget devicesList() {
    return _isConnecting
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Container(
            child: Column(
              children: [
                ...[
                  for (final device in _devices)
                    ListTile(
                      title: Text(
                        device.name ?? device.address,
                        style: const TextStyle(
                            fontFamily: "Rokkitt", fontWeight: FontWeight.bold),
                      ),
                      trailing: ElevatedButton(
                        child: const Text("Connect"),
                        onPressed: () async {
                          setState(() => _isConnecting = true);
                          _connection = await BluetoothConnection.toAddress(
                              device.address);
                          _deviceConnected = device;
                          _devices = [];
                          _isConnecting = false;
                          _receiveData();
                          setState(() {});
                        },
                      ),
                    )
                ]
              ],
            ),
          ));
  }

  Widget manualControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
