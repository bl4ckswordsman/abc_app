import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:math' as math;
import 'update_service.dart';

class ChromeWebView {
  void _launchURL(String urlString, BuildContext context) async {
    try {
      await launchUrl(
        Uri.parse(urlString),
        customTabsOptions: CustomTabsOptions(
          browser: CustomTabsBrowserConfiguration(
            fallbackCustomTabs: [
              'com.android.chrome',
            ],
          ),
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  static const String repoLink = 'https://github.com/bl4ckswordsman/abc_app/';
  static const String repoUri =
      'https://api.github.com/repos/bl4ckswordsman/abc_app/';
  static const String uri = '${repoUri}releases/latest';

  // Get the current theme mode
  AdaptiveThemeMode getThemeMode() {
    return AdaptiveTheme.of(context).mode;
  }

  Future<Map<String, dynamic>> getLatestReleaseInfo() async {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'name': 'Error', 'tag_name': 'Error'};
    }
  }

  bool isVersionGreater(String currentVersion, String latestVersion) {
    List<int> currentParts =
        currentVersion.split('.').map(int.parse).toList();
    List<int> latestParts =
        latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < math.max(currentParts.length, latestParts.length); i++) {
      int currentPart = i < currentParts.length ? currentParts[i] : 0;
      int latestPart = i < latestParts.length ? latestParts[i] : 0;
      if (currentPart < latestPart) {
        return true;
      } else if (currentPart > latestPart) {
        return false;
      }
    }
    return false;
  }

  /// Show a dialog with the latest release information and an update button if an update is available
  void showAndroidUpdates() async {
    // Get the latest release information from GitHub
    final latestRelease = await getLatestReleaseInfo();

    // Get the current app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    // Check if the latest release is newer than the current version
    final latestVersion = latestRelease['tag_name'];
    final latestVersionNum = latestVersion.substring(1);
    final currentVersionNum = currentVersion;
    final isUpdateAvailable =
        isVersionGreater(currentVersionNum, latestVersionNum);

    // Show a dialog with the latest release information and an update button if an update is available
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: isUpdateAvailable
              ? Row(
                  children: [
                    Icon(Icons.new_releases_outlined),
                    SizedBox(width: 8.0),
                    Text('New Update Available')
                  ],
                )
              : Text('Latest Release'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current version: $currentVersion',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Latest version: $latestVersion',
                  style: TextStyle(fontSize: 18),
                ),
                Text.rich(
                  TextSpan(
                    children: latestRelease['body']
                        .split('\n')
                        .map<InlineSpan>((line) {
                      if (line.startsWith('##')) {
                        return TextSpan(
                          text: line.substring(2) + '\n', // Remove '##'
                          style:
                              TextStyle(fontSize: 16), // Apply larger font size
                        );
                      } else {
                        return TextSpan(text: line + '\n');
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            if (isUpdateAvailable)
              TextButton(
                child: Text('Update'),
                onPressed: () async {
                  final apkLink =
                      latestRelease['assets'][0]['browser_download_url'];
                  await UpdateService().downloadAndInstallApk(apkLink);
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inställningar'),
      ),
      body: ListView(
        children: [
          // Switch list element for changing the theme
          SwitchListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Mörkt tema',
                style: TextStyle(fontSize: 20),
              ),
            ),
            value: getThemeMode() == AdaptiveThemeMode.dark,
            onChanged: (value) {
              setState(() {
                // Set the new theme mode
                AdaptiveTheme.of(context).setThemeMode(
                    value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light);
              });
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Build info',
                style: TextStyle(fontSize: 20),
              ),
            ),
            onTap: () {
              showReleaseInfo();
            },
          ),
          !kIsWeb
              ? Platform.isAndroid
                  ? ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          'Sök efter uppdateringar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onTap: () {
                        showAndroidUpdates();
                      },
                    )
                  : ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          'Sök efter uppdateringar',
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                    )
              : ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Text(
                      'Sök efter uppdateringar',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Language',
                style: TextStyle(fontSize: 20),
              ),
            ),
            trailing: LanguageDropdown(),
          ),
        ],
      ),
    );
  }

  void showReleaseInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    // Get the latest release information from GitHub
    final latestRelease = await getLatestReleaseInfo();
    String latestVersion = latestRelease['tag_name'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Build info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current version: v$currentVersion'),
              Text('Latest version: $latestVersion'),
              SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  ChromeWebView()._launchURL(repoLink, context);
                },
                icon: Icon(EvaIcons.github),
                label: Text('GitHub repo'),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum Language {
  swedish,
  english,
}

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  Language _language = Language.swedish;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      value: _language,
      onChanged: (Language? newValue) {
        setState(() {
          _language = newValue!;
        });
      },
      items: Language.values.map<DropdownMenuItem<Language>>((Language value) {
        return DropdownMenuItem<Language>(
          value: value,
          child: Text(getLanguageLabel(value)),
        );
      }).toList(),
    );
  }
}

String getLanguageLabel(Language language) {
  switch (language) {
    case Language.swedish:
      return 'Svenska';
    case Language.english:
      return 'English';
    default:
      return '';
  }
}
