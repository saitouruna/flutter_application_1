import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/emotion_entry.dart';
import '../providers/emotion_provider.dart';

class DailyRecordsScreen extends StatelessWidget {
  final DateTime selectedDate;

  const DailyRecordsScreen({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmotionProvider>(context);
    final day = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final records = provider.emotionEvents[day] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${day.year}/${day.month}/${day.day} の記録'),
      ),
      body: records.isEmpty
          ? const Center(child: Text('この日の記録はありません。'))
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final entry = records[index];
                return ListTile(
                  leading: const Icon(Icons.circle, color: Colors.deepPurple, size: 16),
                  title: Text(entry.emotion),
                  subtitle: Text(entry.note?.isNotEmpty == true ? entry.note! : '（メモなし）'),
                  trailing: Text(
                    '${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')}',
                  ),
                );
              },
            ),
    );
  }
}
