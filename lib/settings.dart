import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

/*class MyWebView extends ChromeSafariBrowser {
  Future openLink(String url) async {
    await open(
      url: Uri.parse(url),
      options: ChromeSafariBrowserClassOptions(
        android: AndroidChromeCustomTabsOptions(
          shareState: CustomTabsShareState.SHARE_STATE_OFF,
        ),
        ios: IOSSafariOptions(
          barCollapsingEnabled: true,
        ),
      ),
    );
  }
}*/

class ChromeWebView {
  void _launchURL(String urlString, BuildContext context) async {
    try {
      await launch(
        urlString,
        customTabsOption: CustomTabsOption(
          extraCustomTabs: const <String>[
            'com.android.chrome',
          ],
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
  //final MyWebView webView = MyWebView();
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

// Define a function to show the latest release information
  void showLatestReleaseInfo() async {
    // Get the latest release information from GitHub
    final latestRelease = await getLatestReleaseInfo();

    // Get the current app version
    const currentVersion = '0.5.6'; // TODO: Get the current app version

    // Check if the latest release is newer than the current version
    final latestVersion = latestRelease['tag_name'];
    final latestVersionNum = latestVersion.substring(1);
    final isUpdateAvailable = latestVersionNum.compareTo(currentVersion) > 0;

    // Show a dialog with the latest release information and an update button if an update is available
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Latest Release'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current version: $currentVersion'),
              Text('Is update available: $isUpdateAvailable'),
              Text('Latest version: $latestVersion'),
              Text('Description: ${latestRelease['body']}'),
              TextButton(
                  child: Text('GitHub repo'),
                  onPressed:
                      () {
                        ChromeWebView()._launchURL(repoLink, context);
                      } 
                  ),
            ],
          ),
          actions: [
            if (isUpdateAvailable)
              TextButton(
                child: Text('Update'),
                onPressed: () {
                  // TODO: Handle update button press
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

          // Clickable placeholder list element
          Platform.isAndroid
              ? ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Text(
                      'Visa senaste versionen',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onTap: () {
                    showLatestReleaseInfo();
                  },
                )
              : ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Text(
                      'Visa senaste versionen',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
