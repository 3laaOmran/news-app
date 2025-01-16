import 'package:flutter/material.dart';
import 'package:news_app/utils/helpers/cash_helper.dart';

class LanguageProvider extends ChangeNotifier{
  String appLanguage = CashHelper.getData(key: 'appLanguage') ?? 'en';

  void changeLanguage({required String newLanguage}) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    CashHelper.saveData(key: 'appLanguage', value: newLanguage);
    notifyListeners();
  }
}

