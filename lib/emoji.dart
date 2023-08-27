import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Emoji {
  static Future<dynamic> emojiDialog(BuildContext context, String letter) {
    // ignore: no_leading_underscores_for_local_identifiers
    late Timer _timer;
    return showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(Duration(seconds: 3), () {
            Navigator.of(builderContext).pop();
          });
          return SimpleDialog(
            //title: Text('Emoji for $letter'),
            shape: CircleBorder(),
            contentPadding: EdgeInsets.all(min(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height) /
                          11),
            children: [
              Center(
                child: Text(
                  Emoji.getEmoji(letter),
                  style: TextStyle(
                      fontSize: min(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height) /
                          2),
                ),
              ),
            ],
          );
        }).then((value) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }


  static final emojis =
{
  "A": ["🐒", "🍍", "⚓", "🍊"],
  "B": ["🚗", "📖", "⚽️", "🍌", "🌺"],
  "C": ["🚲", "🍫", "🎪", "🍋", "⭕️"],
  "D": ["🪆", "🐬", "🐉", "💧", "💎"],
  "E": ["🐘", "🐿", "🔥", "🐞"],
  "F": ["🐦", "🐟", "🦋", "🏁", "🦟"],
  "G": ["🦒", "🎸", "🍦", "🌲", "💛", "🥒"],
  "H": ["🐶", "❤️", "👒", "🐹", "🐴", "🎩"],
  "I": ["🦔", "❄️", "🐻‍❄️"],
  "J": ["🍓", "🐆", "🎄", "🌍"],
  "K": ["🐱", "🐨", "🐰", "🕰", "🍪"],
  "L": ["🦁", "🧅", "💡", "🍃"],
  "M": ["🐭", "🌜", "🐜", "🐛", "🧁"],
  "N": ["🌃", "🦏", "🔑", "👃"],
  "O": ["🐍", "👂", "🧀"],
  "P": ["🐧", "☂️", "👸", "🍐"],
  "Q": ["🇶🇦"],
  "R": ["🐀", "🚀", "🌹", "🦌", "🌈"],
  "S": ["☀️", "🌟", "👟", "🧜‍♀️", "🐌"],
  "T": ["🐯", "🌲", "🚂", "📱", "🎅"],
  "U": ["🦉", "🦦"],
  "V": ["💨", "🐺", "🍉", "🧤", "🌍", "🐳"],
  "W": ["🇼"],
  "X": ["🎮", "❌"],
  "Y": ["🪓"],
  "Z": ["🦓", "🧟‍♂️"],
  "Å": ["🫏", "⚡️"],
  "Ä": ["🍎", "🫎", "🥚"],
  "Ö": ["🦎", "👂", "🏜️"],
};


  static String getEmoji(String letter) {
final emojiList = emojis[letter];
  final randomIndex = Random().nextInt(emojiList!.length);
  return emojiList[randomIndex];
}
}