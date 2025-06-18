import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import '../models/emotion_entry.dart';
import 'emotion_record_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String? _selectedEmotion;
  String? _selectedTag;

  final List<String> _emotionOptions = [
    'すべて',
    '嬉しい',
    '悲しい',
    '怒り',
    '不安',
    '疲れた',
    '元気',
  ];

  final List<String> _tagOptions = [
    'すべて',
    '学校',
    '仕事',
    '趣味',
    '生活',
    'その他',
  ];

  void _resetFilters() {
    setState(() {
      _selectedEmotion = null;
      _selectedTag = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);
    final List<EmotionEntry> records = emotionProvider.history.reversed.toList();

    final filteredRecords = records.where((record) {
      final matchEmotion =
          _selectedEmotion == null || record.emotion == _selectedEmotion;
      final matchTag = _selectedTag == null || record.tag == _selectedTag;
      return matchEmotion && matchTag;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('感情の履歴'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                // 感情ドロップダウン
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedEmotion ?? 'すべて',
                    items: _emotionOptions.map((emotion) {
                      return DropdownMenuItem<String>(
                        value: emotion,
                        child: Text(emotion),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == 'すべて') {
                          _selectedEmotion = null;
                        } else if (_selectedEmotion == value) {
                          _selectedEmotion = null;
                        } else {
                          _selectedEmotion = value;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // タグドロップダウン
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedTag ?? 'すべて',
                    items: _tagOptions.map((tag) {
                      return DropdownMenuItem<String>(
                        value: tag,
                        child: Text(tag),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == 'すべて') {
                          _selectedTag = null;
                        } else if (_selectedTag == value) {
                          _selectedTag = null;
                        } else {
                          _selectedTag = value;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredRecords.isNotEmpty
            ? ListView.builder(
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  final record = filteredRecords[index];
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
                            if (record.tag != null && record.tag!.trim().isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                'タグ: ${record.tag!}',
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ],
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
                  '該当する記録がありません。',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
      ),
    );
  }
}
