import 'package:abc_app/buttons.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'settings.dart';

void main() {
  /*ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );*/
  runApp(const ABCapp());
}

class ABCapp extends StatelessWidget {
  const ABCapp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primaryColor: Colors.deepOrange,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
          title: 'ABC app',
          theme: theme,
          darkTheme: darkTheme,
          home: MyHomePage(),
          routes: {
            '/settings': (context) => SettingsPage(),
          }),
    );
  }
}

/*enum Language {
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
    return DropdownMenu<Language>(
      //initialSelection: Language.swedish,
      label: Text(getLanguageLabel(_language)),
      onSelected: (Language? newValue) {
        setState(() {
          //_language = newValue!;
        });
      },
      dropdownMenuEntries: <DropdownMenuEntry<Language>>[
        DropdownMenuEntry<Language>(
          value: Language.swedish,
          label: getSelectedLanguageLabel(Language.swedish),
        ),
        /*DropdownMenuEntry<Language>(
          value: Language.english,
          label: 'English',
        ),*/
      ],
    );
  }
}

String getSelectedLanguageLabel(Language language) {
  switch (language) {
    case Language.swedish:
      return 'Svenska';
    case Language.english:
      return 'English';
    default:
      return '';
  }
}

String getLanguageLabel(Language language) {
  switch (language) {
    case Language.swedish:
      return 'Språk';
    case Language.english:
      return 'Language';
    default:
      return '';
  }
}*/

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*final List<String> englishAlphabet = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));*/
  final List<String> swedishAlphabet = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index))
    ..addAll(['Å', 'Ä', 'Ö']);

  List<PopupMenuItem> get menuItems => [
        PopupMenuItem(
          child: IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () {
              if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                AdaptiveTheme.of(context).setLight();
              } else {
                AdaptiveTheme.of(context).setDark();
              }
            },
          ),
        ),
        PopupMenuItem(
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('ABC app'),
        actions: [
          /*Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              iconSize: 30.0,
              icon: const Icon(Icons.brightness_4),
              onPressed: () {
                if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                  AdaptiveTheme.of(context).setLight();
                } else {
                  AdaptiveTheme.of(context).setDark();
                }
              },
            ),
          ),*/

          /*// Add the LanguageDropdown widget to the app bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LanguageDropdown(),
          ),*/

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PopupMenuButton(
              iconSize: 30.0,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return menuItems;
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                for (var letter in swedishAlphabet)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AlphabetButton(letter: letter),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
