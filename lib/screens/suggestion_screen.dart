import 'package:flutter/material.dart';
import '../models/suggestion.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Suggestion> suggestions = [
      Suggestion(text: '落ち着く音楽を聴いてみましょう 🎵'),
      Suggestion(text: '外を少し散歩してみましょう 🚶‍♀️'),
      Suggestion(text: '深呼吸して心を整えましょう 🌿'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('今日の提案')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.tips_and_updates),
              title: Text(suggestions[index].text),
            ),
          );
        },
      ),
    );
  }
}
