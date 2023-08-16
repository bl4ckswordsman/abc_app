import 'package:flutter/material.dart';

void main() {
  runApp(const ABCapp());
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
    return DropdownMenu<Language>(
      initialSelection: Language.swedish,
      label: const Text('Language'),
      onSelected: (Language? newValue) {
        setState(() {
          _language = newValue!;
        });
      },
      dropdownMenuEntries: <DropdownMenuEntry<Language>>[
        DropdownMenuEntry<Language>(
          value: Language.swedish,
          label: 'Svenska',
        ),
        DropdownMenuEntry<Language>(
          value: Language.english,
          label: 'English',
        ),
      ],
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


class ABCapp extends StatelessWidget {
  const ABCapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABC app',
      home: MyHomePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> englishAlphabet = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('ABC app'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: LanguageDropdown(),
          ), // Add the LanguageDropdown widget to the app bar
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                for (var letter in englishAlphabet)
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

class AlphabetButton extends StatelessWidget {
  final String letter;

  AlphabetButton({required this.letter});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.0, // Set a fixed width for all buttons
      height: 120.0, // Set a fixed height for all buttons
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        child: Text(letter),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue, shape: CircleBorder(),
          textStyle: TextStyle(fontSize: 60.0),
        ),
      ),
    );
  }
}
