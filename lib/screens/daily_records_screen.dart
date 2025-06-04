import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/emotion_entry.dart';
import '../providers/emotion_provider.dart';
import 'emotion_record_screen.dart';

class DailyRecordsScreen extends StatelessWidget {
  final DateTime selectedDate;

  const DailyRecordsScreen({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);
    final events = emotionProvider.emotionEvents;
    final dateKey = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final records = events[dateKey] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${selectedDate.year}/${selectedDate.month}/${selectedDate.day} の記録',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: '記録を追加',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmotionRecordScreen(initialDate: selectedDate),
                ),
              );
            },
          ),
        ],
      ),
      body: records.isEmpty
          ? const Center(child: Text('記録はありません'))
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final entry = records[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    leading: const Icon(Icons.emoji_emotions),
                    title: Text(entry.emotion),
                    subtitle: Text(entry.note ?? '（メモなし）'),
                    trailing: Text(
                      '${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
