import 'package:abc_app/buttons.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc_app/language_provider.dart';
import 'settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'color_picker_button.dart';

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

  Color _buttonColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _loadButtonColor();
  }

  Future<void> _loadButtonColor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _buttonColor = Color(prefs.getInt('buttonColor') ?? Colors.blue.value);
    });
  }

  Future<void> _saveButtonColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('buttonColor', color.value);
  }

  List<PopupMenuEntry<String>> _buildMenuItems(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
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
  }

  void _handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case 'theme':
        if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
          AdaptiveTheme.of(context).setLight();
        } else {
          AdaptiveTheme.of(context).setDark();
        }
        break;
      case 'settings':
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }

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
          ColorPickerButton(
            initialColor: _buttonColor,
            onColorSelected: (color) {
              setState(() {
                _buttonColor = color;
              });
              _saveButtonColor(color);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PopupMenuButton<String>(
              iconSize: 30.0,
              icon: const Icon(Icons.more_vert),
              itemBuilder: buildMenuItems,
              onSelected: (value) => handleMenuSelection(value, context),
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
