import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const ABCapp());
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


class MyAppState extends ChangeNotifier {
  bool isSwedish = false;
}

class MyHomePage extends StatelessWidget {
  final List<String> englishAlphabet = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<String> get swedishAlphabet =>
      List.from(englishAlphabet)..addAll(['Å', 'Ä', 'Ö']); // Add the Swedish letters

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABC app'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
          shape: CircleBorder(),  // Make the button circular
          primary: Colors.blue,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 60.0),
        ),
      ),
    );
  }
}
