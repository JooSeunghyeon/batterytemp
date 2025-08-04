// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Battery Temperature';

  @override
  String get currentBatteryTemperature => 'Current Battery Temperature';

  @override
  String get showDetailInfo => 'Show Detail Info';

  @override
  String get hideDetailInfo => 'Hide Detail Info';

  @override
  String get tempCold => 'So Cold';

  @override
  String get tempNormal => 'Nice and Cool ~';

  @override
  String get tempWarm => 'Getting Hot';

  @override
  String get tempHot => 'Phone is Dying !!';

  @override
  String get batteryLevel => '🔋 Battery Level';

  @override
  String get batteryStatus => '⚡ Battery Status';

  @override
  String get chargeConnection => '🔌 Charge Connection';

  @override
  String get batteryVoltage => '⚡ Battery Voltage';

  @override
  String get batteryHealth => '💚 Battery Health';

  @override
  String get statusCharging => 'Charging';

  @override
  String get statusDischarging => 'Discharging';

  @override
  String get statusFull => 'Full';

  @override
  String get statusNotCharging => 'Not Charging';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get healthGood => 'Good';

  @override
  String get healthOverheat => 'Overheat';

  @override
  String get healthDead => 'Dead';

  @override
  String get healthOverVoltage => 'Over Voltage';

  @override
  String get healthFailure => 'Failure';

  @override
  String get healthCold => 'Cold';

  @override
  String get healthUnknown => 'Unknown';

  @override
  String get pluggedAC => 'AC Adapter';

  @override
  String get pluggedUSB => 'USB';

  @override
  String get pluggedWireless => 'Wireless';

  @override
  String get pluggedNone => 'Not Connected';

  @override
  String get pluggedOther => 'Other';
}
