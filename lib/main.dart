import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'temperature_service.dart';

void main() {
  runApp(const BatteryTempApp());
}

class BatteryTempApp extends StatelessWidget {
  const BatteryTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Temperature',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
      ),

      // 🌍 언어 테스트용 강제 설정
      // 📖 사용법:
      // 1. 영어 테스트: 아래 첫 번째 줄 주석 해제
      // 2. 한국어 테스트: 아래 두 번째 줄 주석 해제
      // 3. 자동 감지: 두 줄 모두 주석 처리 (기기 언어 설정 따름)
      //
      // locale: const Locale('en'), // 영어 강제 설정 (English)
      // locale: const Locale('ko'), // 한국어 강제 설정 (Korean)
      //
      // ⚠️ 주의: 테스트 후에는 반드시 주석 처리하여 자동 감지 모드로 되돌려주세요!
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ko'), // Korean
      ],
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
    final isKorean = Localizations.localeOf(context).languageCode == 'ko';

    if (temp < 25) return isKorean ? '앗 추워' : 'So Cold';
    if (temp < 35) return isKorean ? '시원하이 좋네 ~ ' : 'Nice and Cool ~';
    if (temp < 40) return isKorean ? '앗 뜨거' : 'Getting Hot';
    return isKorean ? '으아아 폰 죽어 !!' : 'Phone is Dying !!';
  }

  String _translate(String ko, String en) {
    final isKorean = Localizations.localeOf(context).languageCode == 'ko';
    return isKorean ? ko : en;
  }

  String _getBatteryStatusText(String status) {
    final isKorean = Localizations.localeOf(context).languageCode == 'ko';

    switch (status) {
      case '충전중':
        return isKorean ? '충전중' : 'Charging';
      case '방전중':
        return isKorean ? '방전중' : 'Discharging';
      case '완전충전':
        return isKorean ? '완전충전' : 'Full';
      case '충전안함':
        return isKorean ? '충전안함' : 'Not Charging';
      case '알수없음':
        return isKorean ? '알수없음' : 'Unknown';
      default:
        return status;
    }
  }

  String _getBatteryHealthText(String health) {
    final isKorean = Localizations.localeOf(context).languageCode == 'ko';

    switch (health) {
      case '양호':
        return isKorean ? '양호' : 'Good';
      case '과열':
        return isKorean ? '과열' : 'Overheat';
      case '손상':
        return isKorean ? '손상' : 'Dead';
      case '과전압':
        return isKorean ? '과전압' : 'Over Voltage';
      case '오류':
        return isKorean ? '오류' : 'Failure';
      case '저온':
        return isKorean ? '저온' : 'Cold';
      case '알수없음':
        return isKorean ? '알수없음' : 'Unknown';
      default:
        return health;
    }
  }

  String _getPluggedText(String plugged) {
    final isKorean = Localizations.localeOf(context).languageCode == 'ko';

    switch (plugged) {
      case 'AC어댑터':
        return isKorean ? 'AC어댑터' : 'AC Adapter';
      case 'USB':
        return 'USB';
      case '무선충전':
        return isKorean ? '무선충전' : 'Wireless';
      case '연결안됨':
        return isKorean ? '연결안됨' : 'Not Connected';
      case '기타':
        return isKorean ? '기타' : 'Other';
      default:
        return plugged;
    }
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
                      // 디버그용 언어 표시 (릴리즈시 제거)
                      // if (kDebugMode)
                      //   Container(
                      //     padding: const EdgeInsets.all(8),
                      //     margin: const EdgeInsets.only(bottom: 16),
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey[800],
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     child: Text(
                      //       '🌍 현재 언어: ${Localizations.localeOf(context).languageCode.toUpperCase()}',
                      //       style: const TextStyle(
                      //         color: Colors.yellow,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ),
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
                            _translate(
                              '현재 배터리 온도',
                              'Battery Temp',
                            ),
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
                            _isDetailVisible
                                ? _translate('상세 정보 숨기기', 'Hide Detail Info')
                                : _translate('상세 정보 보기', 'Show Detail Info'),
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
                          _translate('🔋 배터리 레벨', '🔋 Battery Level'),
                          '${_batteryInfo!.level}%',
                          _batteryInfo!.level > 20 ? Colors.green : Colors.red,
                        ),

                        // 배터리 상태
                        _buildInfoCard(
                          _translate('⚡ 배터리 상태', '⚡ Battery Status'),
                          _getBatteryStatusText(_batteryInfo!.status),
                          _batteryInfo!.status == '충전중'
                              ? Colors.blue
                              : Colors.white,
                        ),

                        // 충전 연결 상태
                        _buildInfoCard(
                          _translate('🔌 충전 연결', '🔌 Charge Connection'),
                          _getPluggedText(_batteryInfo!.plugged),
                          _batteryInfo!.plugged != '연결안됨'
                              ? Colors.blue
                              : Colors.grey,
                        ),

                        // 배터리 전압
                        _buildInfoCard(
                          _translate('⚡ 배터리 전압', '⚡ Battery Voltage'),
                          '${_batteryInfo!.voltage.toStringAsFixed(2)}V',
                          Colors.cyan,
                        ),

                        // 배터리 건강 상태
                        _buildInfoCard(
                          _translate('💚 배터리 건강', '💚 Battery Health'),
                          _getBatteryHealthText(_batteryInfo!.health),
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
