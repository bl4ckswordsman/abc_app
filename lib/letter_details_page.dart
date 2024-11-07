import 'package:abc_app/buttons.dart';
import 'package:flutter/material.dart';
import 'package:abc_app/emoji.dart';
import 'package:abc_app/animation_controller.dart' as custom_animation;

class LetterDetailsPage extends StatefulWidget {
  final String letter;

  LetterDetailsPage(this.letter);

  @override
  State<LetterDetailsPage> createState() => LetterDetailsPageState();
}

class LetterDetailsPageState extends State<LetterDetailsPage> {
  final custom_animation.AnimationController confettiAnimationController =
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
              Emoji.showEmojiDialog(context, widget.letter);
            },
          ),
        ],
      ),
      body: Center(
        child: confettiAnimationController.getAnimation(
          child: LargeLetterButton(letter: widget.letter),
        ),
      ),
    );
  }
}
