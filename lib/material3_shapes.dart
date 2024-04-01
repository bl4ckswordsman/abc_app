import 'package:flutter/material.dart';

OutlinedBorder circle() {
  return CircleBorder();
}

OutlinedBorder square() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  );
}

OutlinedBorder threePointStar() {
  return StarBorder(
    points: 3,
    innerRadiusRatio: 0.40,
    pointRounding: 0.50,
    valleyRounding: 0.10,
  );
}

OutlinedBorder fourPointStar() {
  return StarBorder(
    points: 4,
    innerRadiusRatio: 0.30,
    pointRounding: 0.80,
    valleyRounding: 0.10,
  );
}

OutlinedBorder fourPointStarRotated() {
  return StarBorder(
    points: 4,
    innerRadiusRatio: 0.35,
    pointRounding: 0.85,
    valleyRounding: 0.10,
    rotation: 45,
  );
}

OutlinedBorder fivePointStar() {
  return StarBorder(
    points: 5,
    innerRadiusRatio: 0.75,
    pointRounding: 0.4,
    valleyRounding: 0.10,
  );
}

OutlinedBorder pentagon() {
  return StarBorder(
    points: 5,
    innerRadiusRatio: 0.80,
    pointRounding: 0.35,
  );
}

OutlinedBorder sixPointStar() {
  return StarBorder(
    points: 6,
    innerRadiusRatio: 0.60,
    pointRounding: 0.85,
    valleyRounding: 0.10,
  );
}

OutlinedBorder hexagon() {
  return StarBorder(
    points: 6,
    innerRadiusRatio: 0.87,
    pointRounding: 0.35,
  );
}

OutlinedBorder eightPointStar() {
  return StarBorder(
    points: 8,
    innerRadiusRatio: 0.70,
    pointRounding: 0.85,
  );
}
