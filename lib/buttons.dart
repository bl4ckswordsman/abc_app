import 'package:abc_app/audio_manager.dart';
import 'package:abc_app/emoji.dart';
import 'package:abc_app/material3_shapes.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:abc_app/confetti_animation.dart';

enum AnimationType { confetti, fireworks }

class AnimationController {
  final AnimationType type;

  AnimationController(this.type);

  Widget getAnimation({required Widget child}) {
    switch (type) {
      case AnimationType.confetti:
        return ConfettiAnimation(child: child);
      case AnimationType.fireworks:
        // return FireworksAnimation(child: child);
        return Container(); // Placeholder for demonstration
    }
  }
}

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

  OutlinedBorder Function() _currentShape = circle;
  @override
  Widget build(BuildContext context) {
    // Get the size of the current screen
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenSize = min(mediaQuery.size.width, mediaQuery.size.height); // Use the smaller dimension

    double buttonSize = screenSize * 0.7; // Ensure button is a square
    double textSize = buttonSize * 0.6;
    return ElevatedButton(
      onPressed: () async {
        // Change button color to random color on press
        Color randomColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)];
        // Play the confetti animation
        context.playConfetti();
        setState(() {
          _buttonColor = randomColor;
        });
        await audioManager.playRandom();
        setState(() {
          _currentShape = shapes[Random().nextInt(shapes.length)];
        });
      },
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

class _LetterDetailsPage extends StatefulWidget {
  final String letter;

  _LetterDetailsPage(this.letter);

  @override
  State<_LetterDetailsPage> createState() => _LetterDetailsPageState();
}

class _LetterDetailsPageState extends State<_LetterDetailsPage> {
  final AnimationController animationController =
      AnimationController(AnimationType.confetti);

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
        child: animationController.getAnimation(
          child: LargeLetterButton(letter: widget.letter),
        ),
      ),
    );
  }
}
