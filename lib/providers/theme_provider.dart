import 'package:flutter/material.dart';
import 'package:news_app/utils/helpers/cash_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.values[CashHelper.getData(key: 'appTheme') ?? 0];

  void changeAppTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
    CashHelper.saveData(key: 'appTheme', value: newTheme.index);
  }

  bool isDark() => appTheme == ThemeMode.dark;
}