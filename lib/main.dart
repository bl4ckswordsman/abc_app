import 'dart:math';

import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

import 'emoji.dart';

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
      ),
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

class MyHomePage extends StatelessWidget {
  /*final List<String> englishAlphabet = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));*/
  final List<String> swedishAlphabet = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index))
    ..addAll(['Å', 'Ä', 'Ö']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('ABC app'),
        actions: [
          Padding(
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

            /*Padding(
            padding: const EdgeInsets.all(16.0),
            child: LanguageDropdown(),
          ),*/ // Add the LanguageDropdown widget to the app bar
          )
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

class _LetterDetailsPage extends StatefulWidget {
  final String letter;

  _LetterDetailsPage(this.letter);

  @override
  State<_LetterDetailsPage> createState() => _LetterDetailsPageState();
}

class _LetterDetailsPageState extends State<_LetterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.letter),
        actions: [
          IconButton(
            iconSize: 40.0,
            icon: const Icon(Icons.emoji_emotions),
            color: Colors.red,
            onPressed: () {
              Emoji.emojiDialog(context, widget.letter);
            },
          ),
        ],
      ),
      body: Center(
        child: LargeLetterButton(letter: widget.letter),
      ),
    );
  }
}

class AlphabetButton extends StatefulWidget {
  final String letter;

  AlphabetButton({required this.letter});

  @override
  State<AlphabetButton> createState() => _AlphabetButtonState();
}

class _AlphabetButtonState extends State<AlphabetButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => _LetterDetailsPage(widget.letter),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            minimumSize: const Size(120, 120),
            shape: CircleBorder(),
          ),
          child: Text(widget.letter,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 60.0)),
        ),
      ],
    );
  }
}

class LargeLetterButton extends StatefulWidget {
  final String letter;

  LargeLetterButton({required this.letter});

  @override
  State<LargeLetterButton> createState() => _LargeLetterButtonState();
}

class _LargeLetterButtonState extends State<LargeLetterButton> {
  Color _buttonColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    // Get the size of the current screen
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

    // Calculate the size of the button
    double buttonWidth = screenWidth * 0.7;
    double buttonHeight = screenHeight * 0.7;

    // Calculate the size of the text
    double textSize = min(buttonWidth, buttonHeight) * 0.6;
    return ElevatedButton(
      onPressed: () {
        // Change button color to random color on press
        Color randomColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)];
        setState(() {
          _buttonColor = randomColor;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: _buttonColor,
        minimumSize: Size(buttonWidth, buttonHeight),
        shape: CircleBorder(),
        splashFactory: InkSparkle.splashFactory,
      ),
      child: Text(widget.letter,
          textAlign: TextAlign.center, style: TextStyle(fontSize: textSize)),
    );
  }
}
