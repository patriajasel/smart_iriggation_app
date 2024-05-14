import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: false));
}

@pragma('vm:entry-point')
void onStart(ServiceInstance serviceInstance) async {
  if (serviceInstance is AndroidServiceInstance) {
    serviceInstance.on('setAsForeground').listen((event) {
      serviceInstance.setAsForegroundService();

      Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (await serviceInstance.isForegroundService()) {
          serviceInstance.setForegroundNotificationInfo(
              title: "Smart Irrigation App",
              content: "Application is running on background.");
        }
        serviceInstance.invoke('update');
      });
    });

    serviceInstance.on('setAsBackground').listen((event) {
      serviceInstance.setAsBackgroundService();
    });
  } else {
    serviceInstance.on('stopService').listen((event) {
      serviceInstance.stopSelf();
    });
  }
}
