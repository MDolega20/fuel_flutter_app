import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message('Fuel app',
        name: 'title', desc: 'The application title');
  }

  String get startText {
    return Intl.message('Welcome in my new fuel app', name: 'startText');
  }

  String get dateTime {
    return Intl.message('date and time', name: 'dateTime');
  }

  String get odometr {
    return Intl.message('odometr', name: 'odometr');
  }

  String get state {
    return Intl.message('state', name: 'state');
  }

  String get price {
    return Intl.message('price', name: 'price');
  }

  String get litres {
    return Intl.message('litres', name: 'litres');
  }

  String get cost {
    return Intl.message('cost', name: 'cost');
  }

  String get fullFueling {
    return Intl.message('full fueling', name: 'fullFueling');
  }

  String get fueling {
    return Intl.message('tankowanie', name: 'fueling');
  }

  String get noEnoughData {
    return Intl.message('not enough data', name: 'noEnoughData');
  }

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['pl', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}