import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:r_upgrade/r_upgrade.dart';



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

//TODO: REMOVE THIS

  set _packageInfo(PackageInfo packageInfo) {}
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

    void upgradeFromUrl()async{
        bool? isSuccess =await RUpgrade.upgradeFromUrl(
                    'https://github.com/bl4ckswordsman/abc_app/releases/download/v0.5.5/abc_app_v0.5.5.apk',
                  );
        print(isSuccess);
    }

        void upgrade() async {
    }

  /*Future<void> downloadLatestApk() async {
  // Get the latest release information from GitHub
  final latestRelease = await getLatestReleaseInfo();

  // Get the URL of the latest APK file
  final apkUrl = latestRelease['assets'][0]['browser_download_url'];

  // Download the APK file
  final response = await http.get(Uri.parse(apkUrl));
  final apkData = await response.bodyBytes;

  // Write the APK file to a temporary directory
  final tempDir = await Directory.systemTemp.createTemp();
  final apkFile = await File('${tempDir.path}/abc_app.apk').writeAsBytes(apkData);

  // Install the APK file
  await AndroidPackageInstaller.installApk(apkFilePath: apkFile.path);
}*/

// Define a function to show the latest release information
  void showAndroidUpdates() async {
    // Get the latest release information from GitHub
    final latestRelease = await getLatestReleaseInfo();

    // Get the current app version
    //const currentVersion = '0.5.4'; // TODO: Get the current app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    // Check if the latest release is newer than the current version
    final latestVersion = latestRelease['tag_name'];
    final latestVersionNum = latestVersion.substring(1);
    final isUpdateAvailable = latestVersionNum.compareTo(currentVersion) > 0;

    // Show a dialog with the latest release information and an update button if an update is available
    // ignore: use_build_context_synchronously
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
                  onPressed: () {
                    ChromeWebView()._launchURL(repoLink, context);
                  }),
            ],
          ),
          actions: [
            if (isUpdateAvailable)
              TextButton(
                child: Text('Update'),
                onPressed: () async {
                    upgrade();
                },// TODO: Handle update button press
                  
              
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
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
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
          Platform.isAndroid
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
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
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
            Text(latestRelease['assets'][0]['browser_download_url']),
          ],
        ),
      );
    },
  );
}
}
