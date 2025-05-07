// lib/screens/emotion_record_screen.dart
import 'package:flutter/material.dart';

class EmotionRecordScreen extends StatelessWidget {
  const EmotionRecordScreen({super.key});

  final List<Map<String, dynamic>> emotions = const [
    {'label': '😊 嬉しい', 'color': Colors.yellow},
    {'label': '😢 悲しい', 'color': Colors.lightBlue},
    {'label': '😠 怒り', 'color': Colors.red},
    {'label': '😰 不安', 'color': Colors.blueGrey},
    {'label': '😴 疲れた', 'color': Colors.purple},
    {'label': '😍 愛情', 'color': Colors.pink},
    {'label': '😐 普通', 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('感情を記録する'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: emotions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2列
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final emotion = emotions[index];
          return GestureDetector(
            onTap: () {
              // TODO: 感情データを保存する処理を実装
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${emotion['label']} を記録しました')),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: emotion['color'],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  emotion['label'],
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
