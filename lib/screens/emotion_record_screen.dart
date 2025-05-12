import 'package:flutter/material.dart';
import '../widgets/emotion_selector.dart';

class EmotionRecordScreen extends StatelessWidget {
  const EmotionRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('感情を記録')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: EmotionSelector(),
      ),
    );
  }
}
