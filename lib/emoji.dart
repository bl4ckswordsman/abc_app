import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';



class Emoji {
  static Future<dynamic> emojiDialog(BuildContext context, String letter) {
    late Timer _timer;
    return showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(Duration(milliseconds: 1500), () {
            Navigator.of(builderContext).pop();
          });
          return SimpleDialog(
            //title: Text('Emoji for $letter'),
            shape: CircleBorder(),
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

  static List<String> emojis = [
    '😀',
    '😃',
    '😄',
    '😅',
    '😆',
    '😉',
    '😊',
    '😋',
    '😌',
    '😍',
  ];

  static String getEmoji(String letter) {
    // Find the first emoji whose name starts with the given letter
    for (String emoji in emojis) {
      if (emoji.startsWith(letter)) {
        return emoji;
      }
    }

    // If no emoji is found, return an empty string
    return '😀';
  }
}
