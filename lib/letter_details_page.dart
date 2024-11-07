import 'package:flutter/material.dart';
import 'package:abc_app/emoji.dart';
import 'package:abc_app/animation_controller.dart' as custom_animation;

class _LetterDetailsPage extends StatefulWidget {
  final String letter;

  _LetterDetailsPage(this.letter);

  @override
  State<_LetterDetailsPage> createState() => _LetterDetailsPageState();
}

class _LetterDetailsPageState extends State<_LetterDetailsPage> {
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
