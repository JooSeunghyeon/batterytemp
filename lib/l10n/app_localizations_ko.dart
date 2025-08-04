// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '배터리 온도';

  @override
  String get currentBatteryTemperature => '현재 배터리 온도';

  @override
  String get showDetailInfo => '상세 정보 보기';

  @override
  String get hideDetailInfo => '상세 정보 숨기기';

  @override
  String get tempCold => '앗 추워';

  @override
  String get tempNormal => '시원하이 좋네 ~';

  @override
  String get tempWarm => '앗 뜨거';

  @override
  String get tempHot => '으아아 폰 죽어 !!';

  @override
  String get batteryLevel => '🔋 배터리 레벨';

  @override
  String get batteryStatus => '⚡ 배터리 상태';

  @override
  String get chargeConnection => '🔌 충전 연결';

  @override
  String get batteryVoltage => '⚡ 배터리 전압';

  @override
  String get batteryHealth => '💚 배터리 건강';

  @override
  String get statusCharging => '충전중';

  @override
  String get statusDischarging => '방전중';

  @override
  String get statusFull => '완전충전';

  @override
  String get statusNotCharging => '충전안함';

  @override
  String get statusUnknown => '알수없음';

  @override
  String get healthGood => '양호';

  @override
  String get healthOverheat => '과열';

  @override
  String get healthDead => '손상';

  @override
  String get healthOverVoltage => '과전압';

  @override
  String get healthFailure => '오류';

  @override
  String get healthCold => '저온';

  @override
  String get healthUnknown => '알수없음';

  @override
  String get pluggedAC => 'AC어댑터';

  @override
  String get pluggedUSB => 'USB';

  @override
  String get pluggedWireless => '무선충전';

  @override
  String get pluggedNone => '연결안됨';

  @override
  String get pluggedOther => '기타';
}
