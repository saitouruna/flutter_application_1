import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import 'emotion_record_screen.dart';
import 'suggestion_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('感情ジャーナル'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: '今日の感情'),
            const SizedBox(height: 10),
            EmotionCard(emotion: emotionProvider.selectedEmotion),
            const SizedBox(height: 30),

            const SectionTitle(title: '次のアクション'),
            const SizedBox(height: 10),

            ActionButton(
              icon: Icons.edit,
              label: '感情を記録する',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EmotionRecordScreen()),
                );
              },
            ),
            const SizedBox(height: 10),

            ActionButton(
              icon: Icons.lightbulb,
              label: '気分に合った提案を見る',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuggestionsScreen()),
                );
              },
            ),
            const SizedBox(height: 10),

            ActionButton(
              icon: Icons.history,
              label: '履歴を見る',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class EmotionCard extends StatelessWidget {
  final String? emotion;
  const EmotionCard({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: emotion != null
          ? Row(
              children: [
                const Icon(Icons.emoji_emotions, size: 32, color: Colors.deepPurple),
                const SizedBox(width: 10),
                Text(
                  emotion!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            )
          : const Text(
              'まだ感情が記録されていません。',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontSize: 16),
      ),
    );
  }
}


