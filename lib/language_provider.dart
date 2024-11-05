import 'package:flutter/material.dart';
import 'translations.dart';

enum Language {
  swedish,
  english,
}

class LanguageProvider with ChangeNotifier {
  Language _language = Language.swedish;

  Language get language => _language;

  String translate(String key) {
    return Translations.get(key, _language);
  }

  void setLanguage(Language language) {
    _language = language;
    notifyListeners();
  }
}

String getLanguageLabel(Language language) {
  switch (language) {
    case Language.swedish:
      return 'Svenska';
    case Language.english:
      return 'English';
  }
}
