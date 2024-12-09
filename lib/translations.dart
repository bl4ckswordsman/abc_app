import 'package:abc_app/language_provider.dart';

class Translations {
  static final Map<String, Map<String, String>> _translations = {
    'en': {
      'pickColor': 'Pick a color',
      'resetToDefault': 'Reset to default',
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
    },
    'sv': {
      'pickColor': 'Välj en färg',
      'resetToDefault': 'Återställ till standard',
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
    },
  };

  static String get(String key, Language language) {
    final languageCode = language == Language.english ? 'en' : 'sv';
    return _translations[languageCode]?[key] ?? key;
  }
}
