import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import '../models/emotion_entry.dart';
import 'emotion_record_screen.dart';

class DailyRecordsScreen extends StatelessWidget {
  final DateTime selectedDate;

  const DailyRecordsScreen({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);

    final dailyRecords = emotionProvider.history.where((entry) {
      return entry.timestamp.year == selectedDate.year &&
          entry.timestamp.month == selectedDate.month &&
          entry.timestamp.day == selectedDate.day;
    }).toList();

    final formattedDate = '${selectedDate.year}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Text('$formattedDate の記録'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // 新規追加
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EmotionRecordScreen(initialDate: selectedDate),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: dailyRecords.isNotEmpty
            ? ListView.builder(
                itemCount: dailyRecords.length,
                itemBuilder: (context, index) {
                  final record = dailyRecords[index];
                  final time = '${record.timestamp.hour.toString().padLeft(2, '0')}:${record.timestamp.minute.toString().padLeft(2, '0')}';

                  return GestureDetector(
                    onTap: () {
                      // 編集モードで開く
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EmotionRecordScreen(
                            initialDate: selectedDate,
                            initialEntry: record,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
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
                              time,
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
                  'この日にはまだ記録がありません。',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
      ),
    );
  }
}
