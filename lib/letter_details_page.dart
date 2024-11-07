import 'package:abc_app/buttons.dart';
import 'package:flutter/material.dart';
import 'package:abc_app/emoji.dart';
import 'package:abc_app/animation_controller.dart' as custom_animation;

class LetterDetailsPage extends StatefulWidget { // Removed underscore
  final String letter;

  LetterDetailsPage(this.letter); // Removed underscore

  @override
  State<LetterDetailsPage> createState() => _LetterDetailsPageState(); // Removed underscore
}

class _LetterDetailsPageState extends State<LetterDetailsPage> { // Removed underscore
  final custom_animation.AnimationController animationController =
      custom_animation.AnimationController(custom_animation.AnimationType.confetti);

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
