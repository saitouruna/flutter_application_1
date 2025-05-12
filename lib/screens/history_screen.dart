import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);
    final records = emotionProvider.emotionRecords.reversed.toList();

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
                  final emotion = record['emotion'];
                  final timestamp = record['timestamp'] as DateTime;
                  final formattedTime =
                      '${timestamp.year}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.day.toString().padLeft(2, '0')} '
                      '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.emoji_emotions),
                      title: Text(emotion),
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
