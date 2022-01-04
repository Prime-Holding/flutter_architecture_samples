// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

class FlutterRxBlocLocalizations {
  static FlutterRxBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterRxBlocLocalizations>(
      context,
      FlutterRxBlocLocalizations,
    )!;
  }

  String get appTitle => 'Rx Bloc Library Example';
}

class FlutterBlocLocalizationsDelegate
    extends LocalizationsDelegate<FlutterRxBlocLocalizations> {
  @override
  Future<FlutterRxBlocLocalizations> load(Locale locale) =>
      Future(() => FlutterRxBlocLocalizations());

  @override
  bool shouldReload(FlutterBlocLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}
