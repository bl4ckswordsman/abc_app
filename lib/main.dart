import 'package:english_words/english_words.dart';
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
  var current = generateWordPairs().first;
}

class MyHomePage extends StatelessWidget {
  final List<String> alphabet = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

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
                for (var letter in alphabet)
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
    return ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      child: Text(letter),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),  // Make the button circular
        primary: Colors.blue,
        onPrimary: Colors.white,
        padding: EdgeInsets.all(40.0),  // Increase padding for a bigger button
        textStyle: TextStyle(fontSize: 50.0),
      ),
    );
  }
}




