import 'package:flutter/services.dart';

class BatteryInfo {
  final double temperature;
  final int level;
  final double voltage;
  final String status;
  final String health;
  final String plugged;
  final int timestamp;

  BatteryInfo({
    required this.temperature,
    required this.level,
    required this.voltage,
    required this.status,
    required this.health,
    required this.plugged,
    required this.timestamp,
  });

  factory BatteryInfo.fromMap(Map<dynamic, dynamic> map) {
    return BatteryInfo(
      temperature: (map['temperature'] as num).toDouble(),
      level: map['level'] as int,
      voltage: (map['voltage'] as num).toDouble(),
      status: map['status'] as String,
      health: map['health'] as String,
      plugged: map['plugged'] as String,
      timestamp: map['timestamp'] as int,
    );
  }
}

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

  static Future<BatteryInfo?> getBatteryInfo() async {
    try {
      final result = await _channel.invokeMethod('getBatteryInfo');
      return BatteryInfo.fromMap(result);
    } catch (e) {
      print("Error getting battery info: $e");
      return null;
    }
  }
}
