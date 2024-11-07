import 'package:flutter/material.dart';
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
