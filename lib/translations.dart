import 'package:abc_app/language_provider.dart';

class Translations {
  static final Map<String, Map<String, String>> _translations = {
    'en': {
      'settings': 'Settings',
      'darkTheme': 'Dark Theme',
      'buildInfo': 'Build info',
      'checkForUpdates': 'Check for updates',
      'language': 'Language',
      'currentVersion': 'Current version',
      'latestVersion': 'Latest version',
      'update': 'Update',
      'close': 'Close',
      'newUpdateAvailable': 'New Update Available',
      'latestRelease': 'Latest Release',
      'githubRepo': 'GitHub repo',
      'switchTheme': 'Switch theme', // Pf7e1
    },
    'sv': {
      'settings': 'Inställningar',
      'darkTheme': 'Mörkt tema',
      'buildInfo': 'Bygginfo',
      'checkForUpdates': 'Sök efter uppdateringar',
      'language': 'Språk',
      'currentVersion': 'Nuvarande version',
      'latestVersion': 'Senaste version',
      'update': 'Uppdatera',
      'close': 'Stäng',
      'newUpdateAvailable': 'Ny uppdatering tillgänglig',
      'latestRelease': 'Senaste versionen',
      'githubRepo': 'GitHub-repo',
      'switchTheme': 'Byt tema', // Pf7e1
    },
  };

  static String get(String key, Language language) {
    final languageCode = language == Language.english ? 'en' : 'sv';
    return _translations[languageCode]?[key] ?? key;
  }
}