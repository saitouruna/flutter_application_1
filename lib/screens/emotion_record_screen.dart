import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import '../models/emotion_entry.dart';

class EmotionRecordScreen extends StatefulWidget {
  final DateTime? initialDate;
  final EmotionEntry? initialEntry;

  const EmotionRecordScreen({
    super.key,
    this.initialDate,
    this.initialEntry,
  });

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

  final List<String> _tags = ['学校', '仕事', '趣味', '生活', 'その他'];

  String? _selectedEmotion;
  String? _selectedTag;

  @override
  void initState() {
    super.initState();
    if (widget.initialEntry != null) {
      _selectedEmotion = widget.initialEntry!.emotion;
      _noteController.text = widget.initialEntry!.note ?? '';
      _selectedTag = widget.initialEntry!.tag;
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
    final isEdit = widget.initialEntry != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '記録の編集' : '感情を記録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '気分を選んでください',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: emotions.map((emotion) {
                final isSelected = emotion['label'] == _selectedEmotion;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedEmotion = emotion['label'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        Text(emotion['emoji'], style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 4),
                        Text(emotion['label'], style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text('タグを選んでください（任意）', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags.map((tag) {
                final selected = _selectedTag == tag;
                return ChoiceChip(
                  label: Text(tag),
                  selected: selected,
                  selectedColor: Colors.deepPurple.shade300,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedTag = selected ? tag : null;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

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

            if (isEdit)
              ElevatedButton.icon(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('削除の確認'),
                      content: const Text('この記録を削除してもよろしいですか？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('削除する', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true && widget.initialEntry != null) {
                    await emotionProvider.deleteEmotion(widget.initialEntry!);
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.delete),
                label: const Text('削除する'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: _selectedEmotion != null
                  ? () async {
                      final note = _noteController.text.trim();

                      if (isEdit && widget.initialEntry != null) {
                        final updated = widget.initialEntry!.copyWith(
                          emotion: _selectedEmotion!,
                          note: note.isEmpty ? null : note,
                          tag: _selectedTag,
                        );
                        await emotionProvider.updateEmotion(updated);
                      } else {
                        final newEntry = EmotionEntry(
                          emotion: _selectedEmotion!,
                          note: note.isEmpty ? null : note,
                          tag: _selectedTag,
                          timestamp: widget.initialDate ?? DateTime.now(),
                        );
                        await emotionProvider.addEmotion(newEntry);
                      }

                      if (!mounted) return;
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('完了'),
                          content: Text(isEdit ? '記録を更新しました。' : '感情を記録しました。'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      if (mounted) Navigator.pop(context);
                    }
                  : null,
              icon: const Icon(Icons.check),
              label: Text(isEdit ? '更新する' : '記録する'),
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
