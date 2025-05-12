import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import 'emotion_record_screen.dart';
import 'suggestion_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('感情ジャーナル'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '今日の感情',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: emotionProvider.selectedEmotion != null
                  ? Row(
                      children: [
                        const Icon(Icons.emoji_emotions, size: 32),
                        const SizedBox(width: 10),
                        Text(
                          emotionProvider.selectedEmotion!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    )
                  : const Text(
                      'まだ感情が記録されていません。',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 30),
            const Text(
              '次のアクション',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('感情を記録する'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EmotionRecordScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.lightbulb),
              label: const Text('気分に合った提案を見る'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuggestionsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
