import 'package:abc_app/emoji.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:abc_app/audio_manager.dart';

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
  // Create an instance of AudioManager
  final AudioManager audioManager = AudioManager();
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
      onPressed: () async {
        // Change button color to random color on press
        Color randomColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)];
        setState(() {
          _buttonColor = randomColor;
        });
        await audioManager.playRandom();
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
