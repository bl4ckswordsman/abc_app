import 'package:abc_app/buttons.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc_app/language_provider.dart';
import 'settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abc_app/color_picker.dart';

class ColorProvider with ChangeNotifier {
  Color _buttonColor = Colors.blue;
  Color _temporaryColor = Colors.blue;
  Color get temporaryColor => _temporaryColor;

  void setTemporaryColor(Color color) {
    _temporaryColor = color;
    notifyListeners();
  }

  Color get buttonColor => _buttonColor;

  void setColor(Color color) {
    _buttonColor = color;
    _saveButtonColor(color);
    notifyListeners();
  }

  Future<void> loadSavedColor() async {
    final prefs = await SharedPreferences.getInstance();
    _buttonColor = Color(prefs.getInt('buttonColor') ?? Colors.blue.value);
    _temporaryColor = _buttonColor;
    notifyListeners();
  }

  Future<void> _saveButtonColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('buttonColor', color.value);
  }
}

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
        ChangeNotifierProvider(
            create: (context) => ColorProvider()..loadSavedColor()),
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
          Consumer<ColorProvider>(
            builder: (context, colorProvider, child) => ColorPickerButton(
              initialColor: colorProvider.buttonColor,
              onColorSelected: (color) => colorProvider.setColor(color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton<String>(
              iconSize: 30.0,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                final languageProvider =
                    Provider.of<LanguageProvider>(context, listen: false);
                return [
                  PopupMenuItem(
                    value: 'theme',
                    child: ListTile(
                      leading: const Icon(Icons.brightness_4),
                      title: Text(languageProvider.translate('darkTheme')),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'settings',
                    child: ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(languageProvider.translate('settings')),
                    ),
                  ),
                ];
              },
              onSelected: (value) {
                switch (value) {
                  case 'theme':
                    if (AdaptiveTheme.of(context).mode ==
                        AdaptiveThemeMode.dark) {
                      AdaptiveTheme.of(context).setLight();
                    } else {
                      AdaptiveTheme.of(context).setDark();
                    }
                    break;
                  case 'settings':
                    Navigator.pushNamed(context, '/settings');
                    break;
                }
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
