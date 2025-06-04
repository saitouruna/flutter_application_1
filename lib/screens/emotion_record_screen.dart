import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/emotion_entry.dart';
import '../providers/emotion_provider.dart';

class EmotionRecordScreen extends StatefulWidget {
  final DateTime? initialDate;
  final EmotionEntry? initialEntry;

  const EmotionRecordScreen({super.key, this.initialDate, this.initialEntry});

  @override
  State<EmotionRecordScreen> createState() => _EmotionRecordScreenState();
}

class _EmotionRecordScreenState extends State<EmotionRecordScreen> {
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> emotions = const [
    {'emoji': '😊', 'label': '嬉しい', 'color': Colors.orange},
    {'emoji': '😢', 'label': '悲しい', 'color': Colors.blue},
    {'emoji': '😠', 'label': '怒り', 'color': Colors.red},
    {'emoji': '😨', 'label': '不安', 'color': Colors.purple},
    {'emoji': '😴', 'label': '疲れた', 'color': Colors.grey},
    {'emoji': '😎', 'label': '元気', 'color': Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialEntry != null) {
      final entry = widget.initialEntry!;
      final emotionProvider = Provider.of<EmotionProvider>(context, listen: false);
      emotionProvider.selectEmotion(entry.emotion);
      _noteController.text = entry.note ?? '';
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialEntry != null ? '記録を編集' : '今日の感情を記録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '今の気分を選んでください',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: emotions.map((emotion) {
                final isSelected =
                    emotion['label'] == emotionProvider.selectedEmotion;
                return GestureDetector(
                  onTap: () {
                    emotionProvider.selectEmotion(emotion['label']);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? emotion['color'].withOpacity(0.8)
                          : emotion['color'].withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          emotion['emoji'],
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          emotion['label'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            /// 📝 日記テキストフィールド
            TextField(
              controller: _noteController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: '今日のことや心に残ったことを書いてみましょう',
                hintText: '例：公園を散歩して気持ちが落ち着いた',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),

            /// ✅ 記録ボタン
            ElevatedButton.icon(
              onPressed: emotionProvider.selectedEmotion != null
                  ? () async {
                      final note = _noteController.text.trim();
                      final date = widget.initialEntry?.timestamp ?? widget.initialDate ?? DateTime.now();

                      if (widget.initialEntry != null) {
                        final updatedEntry = widget.initialEntry!.copyWith(
                          emotion: emotionProvider.selectedEmotion!,
                          note: note.isEmpty ? null : note,
                        );
                        await emotionProvider.updateEmotion(updatedEntry);
                      } else {
                        await emotionProvider.saveEmotionWithNote(note.isEmpty ? null : note, date: date);
                      }

                      if (mounted) Navigator.pop(context);
                    }
                  : null,
              icon: const Icon(Icons.check),
              label: const Text('記録する'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}