import 'package:abc_app/audio_manager.dart';
import 'package:abc_app/material3_shapes.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:abc_app/confetti_animation.dart';
import 'package:abc_app/letter_details_page.dart';

List<OutlinedBorder Function()> shapes = [
  circle,
  square,
  threePointStar,
  fourPointStar,
  fourPointStarRotated,
  fivePointStar,
  pentagon,
  sixPointStar,
  hexagon,
  eightPointStar,
];

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
                builder: (context) => LetterDetailsPage(widget.letter), // Updated reference
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

  OutlinedBorder Function() _currentShape = circle;

  void handleButtonPress() async {
    _changeButtonColor();
    _playConfetti();
    await _playRandomSound();
    _changeButtonShape();
  }

  void _changeButtonColor() {
    Color randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    setState(() {
      _buttonColor = randomColor;
    });
  }

  void _playConfetti() {
    context.playConfetti();
  }

  Future<void> _playRandomSound() async {
    await audioManager.playRandom();
  }

  void _changeButtonShape() {
    setState(() {
      _currentShape = shapes[Random().nextInt(shapes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenSize = min(mediaQuery.size.width, mediaQuery.size.height);
    double buttonSize = screenSize * 0.7;
    double textSize = buttonSize * 0.6;

    return buildButton(buttonSize, textSize);
  }

  Widget buildButton(double buttonSize, double textSize) {
    return ElevatedButton(
      onPressed: handleButtonPress,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: _buttonColor,
        minimumSize: Size(buttonSize, buttonSize),
        shape: _currentShape(),
        splashFactory: InkSparkle.splashFactory,
      ),
      child: Text(widget.letter,
          textAlign: TextAlign.center, style: TextStyle(fontSize: textSize)),
    );
  }
}
