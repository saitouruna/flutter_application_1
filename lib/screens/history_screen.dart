import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import '../models/emotion_entry.dart';
import 'emotion_record_screen.dart'; // ← 追加：編集画面を使うため

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

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EmotionRecordScreen(
                            initialEntry: record,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.emoji_emotions, color: Colors.deepPurple),
                                const SizedBox(width: 8),
                                Text(
                                  record.emotion,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              formattedTime,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            if (record.note != null && record.note!.trim().isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                record.note!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ],
                        ),
                      ),
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
