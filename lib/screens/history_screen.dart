import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import '../models/emotion_entry.dart'; // EmotionEntry のモデルを使う

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);
    final List<EmotionEntry> records = emotionProvider.history.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('感情の履歴'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: records.isNotEmpty
            ? ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  final formattedTime =
                      '${record.timestamp.year}/${record.timestamp.month.toString().padLeft(2, '0')}/${record.timestamp.day.toString().padLeft(2, '0')} '
                      '${record.timestamp.hour.toString().padLeft(2, '0')}:${record.timestamp.minute.toString().padLeft(2, '0')}';

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.emoji_emotions),
                      title: Text(record.emotion),
                      subtitle: Text(formattedTime),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'まだ感情の記録がありません。',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
      ),
    );
  }
}
