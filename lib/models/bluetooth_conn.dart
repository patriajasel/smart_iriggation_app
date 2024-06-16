import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_iriggation_app/pages/auto_crop_list.dart';
import 'package:smart_iriggation_app/pages/dash_node_monitor_page.dart';
import 'package:smart_iriggation_app/pages/dash_tank_monitor.dart';

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
          receiveData();
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
    if (connection?.isConnected ?? false) {
      connection?.input = connection?.input?.asBroadcastStream();
      connection?.input?.listen(onDataReceived).onDone(() {
        print('Receiving Data');
      });
    }
  }

  void onDataReceived(Uint8List data) {
    // Handle received data from Arduino here
    dataReceived = String.fromCharCodes(data);
    List<String> returnedData = dataReceived!.split(',');

    //print(returnedData);
    if (returnedData[0] == "I") {
      soilType = returnedData[1];
    } else if (returnedData[0] == "Moni") {
      waterLevel =
          (returnedData.length > 1) ? int.tryParse(returnedData[1]) ?? 0 : 0;
      fertilizerLevel =
          (returnedData.length > 2) ? int.tryParse(returnedData[2]) ?? 0 : 0;
      soilMoisture1 =
          (returnedData.length > 3) ? int.tryParse(returnedData[3]) ?? 0 : 0;
      soilMoisture2 =
          (returnedData.length > 4) ? int.tryParse(returnedData[4]) ?? 0 : 0;
      soilMoisture3 =
          (returnedData.length > 5) ? int.tryParse(returnedData[5]) ?? 0 : 0;
      soilMoisture4 =
          (returnedData.length > 6) ? int.tryParse(returnedData[6]) ?? 0 : 0;
    }

    returnedData.clear();
    dataReceived = "";
  }

  void sendData(String data, BuildContext context) {
    if (connection?.isConnected ?? false) {
      connection?.output.add(ascii.encode(data));
    }

    print(data);
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
