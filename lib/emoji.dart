import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';

class Emoji {
  static Future<dynamic> showEmojiDialog(BuildContext context, String letter) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    return showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        _startTimer(builderContext);
        return _buildDialog(context, letter, languageProvider);
      },
    ).then((value) {
      _cancelTimer();
    });
  }

  static Timer? _timer;

  static void _startTimer(BuildContext context) {
    _timer = Timer(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  static void _cancelTimer() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }

  static SimpleDialog _buildDialog(BuildContext context, String letter, LanguageProvider languageProvider) {
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
      "I": ["🦔", "❄️", "🐻‍❄️", "🦎", "🧊"],
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
      "C": ["🐱", "🍪", "🤡", "🎪", "👑"],
      "D": ["🦮", "🎲", "🦌", "🍩", "💃", "💎"],
      "E": ["🦅", "🥚", "👁️", "🐘"],
      "F": ["🐟", "🌸", "🦊", "🔥", "🍟"],
      "G": ["🦒", "🎸", "👻", "🎮", "🍇"],
      "H": ["🏠", "🐹", "🎩", "🚁", "♥️"],
      "I": ["🍦", "🏝️", "🦎", "🧊"],
      "J": ["🕹️", "💎", "🃏", "🧃"],
      "K": ["🔑", "🪁", "🦘", "🥝"],
      "L": ["🦁", "🍃", "💡", "🦙", "🦎"],
      "M": ["🌙", "🍄", "🎵", "🗺️"],
      "N": ["📰", "🌃", "👃"],
      "O": ["🐙", "🦉", "🍊", "🧅"],
      "P": ["🐼", "🥞", "🎨", "🌴", "📱"],
      "Q": ["👸", "❓"],
      "R": ["🌹", "🤖", "🌈", "🚀"],
      "S": ["⭐", "🌞", "🐍", "🏄"],
      "T": ["🌳", "🐯", "🚂", "☎️"],
      "U": ["☔", "🦄", "🌂", "🛸"],
      "V": ["🎻", "🌋", "🎮", "🚐", "🏐"],
      "W": ["🌊", "🐋", "⌚", "🍉", "🐺", "💧"],
      "X": ["❌", "🎮"],
      "Y": ["💛", "🪀", "🧘"],
      "Z": ["🧟", "🦓", "0️⃣", "💤"],
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
