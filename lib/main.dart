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
      title: '배터리 정보',
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
  BatteryInfo? _batteryInfo;
  Timer? _timer;
  bool _isDetailVisible = false;

  Future<void> _updateBatteryInfo() async {
    final info = await TemperatureService.getBatteryInfo();
    final now = DateTime.now();
    setState(() {
      _batteryInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateBatteryInfo(); // 최초 1회
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateBatteryInfo(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color _getTemperatureColor(double temp) {
    if (temp < 25) return Colors.white;
    if (temp < 35) return Colors.white;
    if (temp < 40) return Colors.red;
    return Colors.red;
  }

  String _getTemperatureImage(double temp) {
    if (temp < 25) return 'assets/images/1.png'; // 차가움
    if (temp < 35) return 'assets/images/2.png'; // 정상
    if (temp < 40) return 'assets/images/3.png'; // 과열
    return 'assets/images/3.png'; // 과열
  }

  String _getTemperatureText(double temp) {
    if (temp < 25) return '앗 추워';
    if (temp < 35) return '시원하이 좋네 ~ ';
    if (temp < 40) return '앗 뜨거';
    return '으아아 폰 죽어 !!';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _batteryInfo == null
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 캐릭터 영역
                      Column(
                        children: [
                          // 온도별 캐릭터 이미지
                          Image.asset(
                            _getTemperatureImage(_batteryInfo!.temperature),
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // 이미지 로드 실패 시 이모지 표시
                              return Center(
                                child: Text(
                                  _getTemperatureText(
                                    _batteryInfo!.temperature,
                                  ).split(' ')[1],
                                  style: const TextStyle(fontSize: 60),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 25),

                          // 온도 표시
                          Text(
                            '현재 배터리 온도',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Pretendard',
                            ),
                          ),

                          const SizedBox(height: 20),

                          // 온도 표시
                          Text(
                            '${_batteryInfo!.temperature.toStringAsFixed(1)} °C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard',
                            ),
                          ),
                          const SizedBox(height: 10),

                          // 상태 텍스트
                          Text(
                            _getTemperatureText(_batteryInfo!.temperature),
                            style: TextStyle(
                              color: _getTemperatureColor(
                                _batteryInfo!.temperature,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // 상세 정보 토글 버튼
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isDetailVisible = !_isDetailVisible;
                            });
                          },
                          icon: Icon(
                            _isDetailVisible
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                          label: Text(
                            _isDetailVisible ? '상세 정보 숨기기' : '상세 정보 보기',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 상세 정보 (조건부 표시)
                      if (_isDetailVisible) ...[
                        // 배터리 레벨
                        _buildInfoCard(
                          '🔋 배터리 레벨',
                          '${_batteryInfo!.level}%',
                          _batteryInfo!.level > 20 ? Colors.green : Colors.red,
                        ),

                        // 배터리 상태
                        _buildInfoCard(
                          '⚡ 배터리 상태',
                          _batteryInfo!.status,
                          _batteryInfo!.status == '충전중'
                              ? Colors.blue
                              : Colors.white,
                        ),

                        // 충전 연결 상태
                        _buildInfoCard(
                          '🔌 충전 연결',
                          _batteryInfo!.plugged,
                          _batteryInfo!.plugged != '연결안됨'
                              ? Colors.blue
                              : Colors.grey,
                        ),

                        // 배터리 전압
                        _buildInfoCard(
                          '⚡ 배터리 전압',
                          '${_batteryInfo!.voltage.toStringAsFixed(2)}V',
                          Colors.cyan,
                        ),

                        // 배터리 건강 상태
                        _buildInfoCard(
                          '💚 배터리 건강',
                          _batteryInfo!.health,
                          _batteryInfo!.health == '양호'
                              ? Colors.green
                              : Colors.orange,
                        ),

                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pretendard',
            ),
          ),
        ],
      ),
    );
  }
}
