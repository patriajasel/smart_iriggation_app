import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

final bluetooth = FlutterBluetoothSerial.instance;
bool bluetoothState = false;
BluetoothConnection? connection;
List<BluetoothDevice> devices = [];
BluetoothDevice? deviceConnected;

String? soilType;

class bluetooth_conn {
  void getDevices() async {
    try {
      var res = await bluetooth.getBondedDevices();
      devices = res;
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
    soilType = String.fromCharCodes(data);
  }

  void sendData(String data) {
    if (connection?.isConnected ?? false) {
      connection?.output.add(ascii.encode(data));
    }
  }

  void requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
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
