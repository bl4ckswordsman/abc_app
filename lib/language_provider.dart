import 'package:flutter/material.dart';

enum Language {
  swedish,
  english,
}

class LanguageProvider with ChangeNotifier {
  Language _language = Language.swedish;

  Language get language => _language;

  void setLanguage(Language language) {
    _language = language;
    notifyListeners();
  }
}
