import 'package:flutter/services.dart';

class TemperatureService {
  static const MethodChannel _channel = MethodChannel(
    'com.juseunghyeon.batterytemp/temperature',
  );

  static Future<double?> getBatteryTemperature() async {
    try {
      final temp = await _channel.invokeMethod('getBatteryTemperature');
      return temp;
    } catch (e) {
      print("Error getting battery temperature: $e");
      return null;
    }
  }
}
