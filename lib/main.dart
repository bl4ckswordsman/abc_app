import 'package:abc_app/buttons.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc_app/language_provider.dart';
import 'settings.dart';

void main() {
  runApp(const ABCapp());
}

class ABCapp extends StatelessWidget {
  const ABCapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: AdaptiveTheme(
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
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> englishAlphabet = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  final List<String> swedishAlphabet = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index))
    ..addAll(['Å', 'Ä', 'Ö']);

  List<PopupMenuItem> get menuItems => [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.brightness_4),
            title: Text('Switch theme'),
            onTap: () {
              if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                AdaptiveTheme.of(context).setLight();
              } else {
                AdaptiveTheme.of(context).setDark();
              }
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedAlphabet = languageProvider.language == Language.swedish
        ? swedishAlphabet
        : englishAlphabet;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('ABC app'),
        actions: [
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
                for (var letter in selectedAlphabet)
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
