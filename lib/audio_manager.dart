import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class AudioManager {
final List<String> soundEffects = [
  'funny-spring-jump.mp3',
  'cartoon-jump.mp3',
  'happy-harp-sound.mp3',
  'happy-logo-167474.mp3',
  'mixkit-cartoon-little-cat-meow.wav',
  'mixkit-dog-barking-twice.wav',
];
  final AudioPlayer audioPlayer;

  AudioManager() : audioPlayer = AudioPlayer();

  Future<void> playRandom() async {
    int randomIndex = Random().nextInt(soundEffects.length);
    await audioPlayer.play(AssetSource('sounds/${soundEffects[randomIndex]}'));
  }
}
