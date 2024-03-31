import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ConfettiAnimation extends StatefulWidget {
  final Widget child;
  final Alignment alignment;

  ConfettiAnimation({required this.child, this.alignment = Alignment.center});

  @override
  _ConfettiAnimationState createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void playConfetti() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 0,
          left: screenSize.width / 2, // center horizontally
          child: Transform.translate(
            offset: Offset(-screenSize.width / 7,
                0), // adjust the position of the ConfettiWidget
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // radial value - DOWN
              particleDrag: 0.05, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: 20, // number of particles to emit
              gravity: 0.05, // gravity - or how fast they should fall
              shouldLoop:
                  false, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
            ),
          ),
        ),
      ],
    );
  }
}

extension ConfettiAnimationExtension on BuildContext {
  void playConfetti() {
    findAncestorStateOfType<_ConfettiAnimationState>()?.playConfetti();
  }
}
