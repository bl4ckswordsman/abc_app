import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Get the current theme mode
  AdaptiveThemeMode getThemeMode() {
    return AdaptiveTheme.of(context).mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // Switch list element for changing the theme
          SwitchListTile(
            title: Text('Dark mode'),
            value: getThemeMode() == AdaptiveThemeMode.dark,
            onChanged: (value) {
              setState(() {
                // Set the new theme mode
                AdaptiveTheme.of(context).setThemeMode(value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light);
              });
            },
          ),

          // Clickable placeholder list element
          ListTile(
            title: Text('Placeholder'),
            onTap: () {
              // Add your code here to handle the tap event
            },
          ),
        ],
      ),
    );
  }
}
