import 'dart:async';
import 'package:flutter/material.dart';
import 'temperature_service.dart';

void main() {
  runApp(const BatteryTempApp());
}

class BatteryTempApp extends StatelessWidget {
  const BatteryTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '배터리 온도',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
      ),
      home: const TemperatureHomePage(),
    );
  }
}

class TemperatureHomePage extends StatefulWidget {
  const TemperatureHomePage({super.key});

  @override
  State<TemperatureHomePage> createState() => _TemperatureHomePageState();
}

class _TemperatureHomePageState extends State<TemperatureHomePage> {
  double? _temperature;
  Timer? _timer;

  Future<void> _updateTemperature() async {
    final temp = await TemperatureService.getBatteryTemperature();
    setState(() {
      _temperature = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateTemperature(); // 최초 1회
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateTemperature(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _temperature == null
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                '배터리 온도\n${_temperature!.toStringAsFixed(1)} °C',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pretendard',
                ),
              ),
      ),
    );
  }
}
