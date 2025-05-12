import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import '../services/emotion_analysis.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);
    final currentEmotion = emotionProvider.selectedEmotion ?? '未選択';
    final suggestions = EmotionAnalysisService.getSuggestionsFromEmotion(currentEmotion);

    return Scaffold(
      appBar: AppBar(
        title: const Text('気分に合わせた提案'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '今の感情: $currentEmotion',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'おすすめの行動・アイデア：',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ...suggestions.map((s) => Card(
                  color: Colors.teal.shade50,
                  child: ListTile(
                    leading: const Icon(Icons.lightbulb),
                    title: Text(s),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
