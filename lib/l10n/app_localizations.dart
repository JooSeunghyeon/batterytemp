import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery Temperature'**
  String get appTitle;

  /// No description provided for @currentBatteryTemperature.
  ///
  /// In en, this message translates to:
  /// **'Current Battery Temperature'**
  String get currentBatteryTemperature;

  /// No description provided for @showDetailInfo.
  ///
  /// In en, this message translates to:
  /// **'Show Detail Info'**
  String get showDetailInfo;

  /// No description provided for @hideDetailInfo.
  ///
  /// In en, this message translates to:
  /// **'Hide Detail Info'**
  String get hideDetailInfo;

  /// No description provided for @tempCold.
  ///
  /// In en, this message translates to:
  /// **'So Cold'**
  String get tempCold;

  /// No description provided for @tempNormal.
  ///
  /// In en, this message translates to:
  /// **'Nice and Cool ~'**
  String get tempNormal;

  /// No description provided for @tempWarm.
  ///
  /// In en, this message translates to:
  /// **'Getting Hot'**
  String get tempWarm;

  /// No description provided for @tempHot.
  ///
  /// In en, this message translates to:
  /// **'Phone is Dying !!'**
  String get tempHot;

  /// No description provided for @batteryLevel.
  ///
  /// In en, this message translates to:
  /// **'🔋 Battery Level'**
  String get batteryLevel;

  /// No description provided for @batteryStatus.
  ///
  /// In en, this message translates to:
  /// **'⚡ Battery Status'**
  String get batteryStatus;

  /// No description provided for @chargeConnection.
  ///
  /// In en, this message translates to:
  /// **'🔌 Charge Connection'**
  String get chargeConnection;

  /// No description provided for @batteryVoltage.
  ///
  /// In en, this message translates to:
  /// **'⚡ Battery Voltage'**
  String get batteryVoltage;

  /// No description provided for @batteryHealth.
  ///
  /// In en, this message translates to:
  /// **'💚 Battery Health'**
  String get batteryHealth;

  /// No description provided for @statusCharging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get statusCharging;

  /// No description provided for @statusDischarging.
  ///
  /// In en, this message translates to:
  /// **'Discharging'**
  String get statusDischarging;

  /// No description provided for @statusFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get statusFull;

  /// No description provided for @statusNotCharging.
  ///
  /// In en, this message translates to:
  /// **'Not Charging'**
  String get statusNotCharging;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @healthGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get healthGood;

  /// No description provided for @healthOverheat.
  ///
  /// In en, this message translates to:
  /// **'Overheat'**
  String get healthOverheat;

  /// No description provided for @healthDead.
  ///
  /// In en, this message translates to:
  /// **'Dead'**
  String get healthDead;

  /// No description provided for @healthOverVoltage.
  ///
  /// In en, this message translates to:
  /// **'Over Voltage'**
  String get healthOverVoltage;

  /// No description provided for @healthFailure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get healthFailure;

  /// No description provided for @healthCold.
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get healthCold;

  /// No description provided for @healthUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get healthUnknown;

  /// No description provided for @pluggedAC.
  ///
  /// In en, this message translates to:
  /// **'AC Adapter'**
  String get pluggedAC;

  /// No description provided for @pluggedUSB.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get pluggedUSB;

  /// No description provided for @pluggedWireless.
  ///
  /// In en, this message translates to:
  /// **'Wireless'**
  String get pluggedWireless;

  /// No description provided for @pluggedNone.
  ///
  /// In en, this message translates to:
  /// **'Not Connected'**
  String get pluggedNone;

  /// No description provided for @pluggedOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get pluggedOther;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
