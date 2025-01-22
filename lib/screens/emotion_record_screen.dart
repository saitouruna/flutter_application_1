// lib/screens/emotion_record_screen.dart
import 'package:flutter/material.dart';

class EmotionRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Record Screen'),
      ),
      body: const Center(
        child: Text('Here you can record your emotions!'),
      ),
    );
  }
}
