import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

String? dataReceived;

final bluetooth = FlutterBluetoothSerial.instance;
bool bluetoothState = false;
List<BluetoothDevice> devices = [];
BluetoothDevice? deviceConnected;
BluetoothConnection? connection;

class bluetooth_conn {
  void getDevices() async {
    var status = await Permission.bluetoothConnect.status;
    try {
      if (status.isGranted) {
        var res = await bluetooth.getBondedDevices();
        devices = res;
      } else if (status.isDenied) {
        // Permission is denied, request permissions
        await Permission.bluetoothConnect.request();
      } else if (status.isPermanentlyDenied) {
        // Permission is permanently denied, navigate to settings
        openAppSettings();
      }
    } on PlatformException {
      print("Permission needed are not accepted");
    } catch (e) {}

    connectToHC05();
  }

  void connectToHC05() async {
    try {
      for (final device in devices) {
        if (device.name == "HC-05" && device.address == "58:56:00:00:56:64") {
          connection = await BluetoothConnection.toAddress(device.address);
          deviceConnected = device;
          return; // Exit the loop once connected
        }
      }
      // If the loop completes without finding the device
    } on Exception catch (e) {
      print("Failed to connect to HC-05: $e");
    } catch (e) {
      // Handle the exception here
      print("Failed to connect to HC-05: $e");
      // You can perform additional error handling here
    }
  }

  void receiveData() {
    connection?.input?.listen(onDataReceived).onDone(() {
      print('Receiving Data');
    });
  }

  void onDataReceived(Uint8List data) {
    // Handle received data from Arduino here
    dataReceived = String.fromCharCodes(data);
  }

  void sendData(String data, BuildContext context) {
    if (connection?.isConnected ?? false) {
      connection?.output.add(ascii.encode(data));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are currently not connected to Bluetooth HC-05'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    //await Permission.bluetoothConnect.request();
    print("Requesting permission");
  }

  void bluetoothStateListener() {
    bluetooth.state.then((state) {
      bluetoothState = state.isEnabled;
      getDevices();
    });

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          bluetoothState = false;
          deviceConnected = null;
          break;
        case BluetoothState.STATE_ON:
          bluetoothState = true;
          getDevices();
          break;
        // case BluetoothState.STATE_TURNING_OFF:
        //   break;
        // case BluetoothState.STATE_TURNING_ON:
        //   break;
      }
    });
  }
}
