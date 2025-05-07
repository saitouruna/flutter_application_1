// lib/screens/suggestions_screen.dart
import 'package:flutter/material.dart';

class SuggestionScreen extends StatelessWidget {

  final List<Map<String, String>> suggestions = const [
    {'mood': '😊 嬉しい', 'suggestion': '友達にメッセージを送って共有しよう！'},
    {'mood': '😢 悲しい', 'suggestion': '落ち着いた音楽を聴いてリラックスしましょう。'},
    {'mood': '😠 怒り', 'suggestion': '深呼吸して少し散歩しよう。'},
    {'mood': '😰 不安', 'suggestion': '短い瞑想を試してみよう。'},
    {'mood': '😴 疲れた', 'suggestion': '10分間目を閉じて休憩しましょう。'},
    {'mood': '😍 愛情', 'suggestion': '感謝の気持ちを誰かに伝えよう！'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('あなたへのおすすめ'),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        itemCount: suggestions.length,
        padding: const EdgeInsets.all(16),

        itemBuilder: (context, index) {
          final item = suggestions[index];
          return Card(
            color: Colors.primaries[index % Colors.primaries.length].shade200,
            child: ListTile(
              title: Text(
                item['mood']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['suggestion']!),
            ),
          );
        },
      ),
    );
  }
}
