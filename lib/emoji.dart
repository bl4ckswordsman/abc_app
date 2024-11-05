import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';

class Emoji {
  static Future<dynamic> emojiDialog(BuildContext context, String letter) {
    late Timer timer;
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    return showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          timer = Timer(Duration(seconds: 3), () {
            Navigator.of(builderContext).pop();
          });
          return SimpleDialog(
            shape: CircleBorder(),
            contentPadding: EdgeInsets.all(min(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height) /
                11),
            children: [
              Center(
                child: Text(
                  getEmoji(letter, languageProvider.language),
                  style: TextStyle(
                      fontSize: min(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height) /
                          2),
                ),
              ),
            ],
          );
        }).then((value) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }

  static final Map<Language, Map<String, List<String>>> _emojiSets = {
    Language.swedish: {
      "A": ["🐒", "🍍", "⚓", "🍊", "🦆"],
      "B": ["🚗", "📖", "⚽️", "🍌", "🌺"],
      "C": ["🚲", "🍫", "🎪", "🍋", "⭕️"],
      "D": ["🪆", "🐬", "🐉", "💧", "💎"],
      "E": ["🐘", "🐿", "🔥"],
      "F": ["🐦", "🐟", "🦋", "🏁", "🦩"],
      "G": ["🦒", "🎸", "🍦", "🌲", "💛", "🥒"],
      "H": ["🐶", "❤️", "👒", "🐹", "🐴", "🎩"],
      "I": ["🦔", "❄️", "🐻‍❄️"],
      "J": ["🍓", "🐆", "🎄", "🌍"],
      "K": ["🐱", "🐨", "🐰", "🕰", "🍪"],
      "L": ["🦁", "🧅", "💡", "🍃"],
      "M": ["🐭", "🌜", "🐜", "🐛", "🧁"],
      "N": ["🐞", "🦏", "🔑", "👃"],
      "O": ["🐍", "🧀"],
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
    },
    Language.english: {
      "A": ["🍎", "✈️", "🐜", "⚓", "👽"],
      "B": ["🎈", "🐻", "🚲", "📚", "🍌"],
      "C": ["🐱", "🍪", "🤡", "🎪", "🥤"],
      "D": ["🦮", "🎲", "🦌", "🍩", "💃"],
      "E": ["🦅", "🥚", "👁️", "🎨", "🐘"],
      "F": ["🐟", "🌸", "🦊", "🔥", "🍟"],
      "G": ["🦒", "🎸", "👻", "🎮", "🍇"],
      "H": ["🏠", "🐹", "🎩", "🚁", "♥️"],
      "I": ["🍦", "👀", "🏝️", "🎪", "🌊"],
      "J": ["🤹", "🎭", "🕹️", "💎", "🃏"],
      "K": ["🔑", "🪁", "👑", "🦘", "🥝"],
      "L": ["🦁", "🍃", "💡", "🦎", "🎪"],
      "M": ["🌙", "🍄", "🎵", "🗺️", "🎪"],
      "N": ["📰", "🌙", "🎵", "⚡", "👃"],
      "O": ["🐙", "🦉", "🍊", "🌊", "⭕"],
      "P": ["🐼", "🥞", "🎨", "🌴", "📱"],
      "Q": ["👸", "❓", "🎯", "🎭"],
      "R": ["🌹", "🤖", "🌈", "🚀", "🎸"],
      "S": ["⭐", "🌞", "🎪", "🐍", "🏄"],
      "T": ["🌳", "🐯", "🎪", "🚂", "☎️"],
      "U": ["☔", "🦄", "🌂", "🎓", "🌙"],
      "V": ["🎻", "🌋", "🎮", "🚐", "🌺"],
      "W": ["🌊", "🐋", "⌚", "🌍", "🎐"],
      "X": ["❌", "🎸", "📦", "🎯", "⚔️"],
      "Y": ["🧒", "💛", "🪀", "🎪", "🎭"],
      "Z": ["⚡", "🦓", "🎪", "🎭", "💤"],
    },
  };

  static String getEmoji(String letter, Language language) {
    final emojiList = _emojiSets[language]?[letter];
    if (emojiList == null || emojiList.isEmpty) {
      return "❓"; // Return a question mark if no emoji is found
    }
    final randomIndex = Random().nextInt(emojiList.length);
    return emojiList[randomIndex];
  }
}
