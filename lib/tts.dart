import 'package:flutter_tts/flutter_tts.dart';

void speakText(String inString, String inLanguage) async {
  final FlutterTts flutterTts = FlutterTts();
  //SpeakText(this.inString);
  //final String inString;

  await flutterTts.setLanguage(inLanguage);
  await flutterTts.setPitch(1);
  await flutterTts.setVolume(0.7);
  await flutterTts.speak(inString);
}
