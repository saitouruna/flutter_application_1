import 'package:flutter/material.dart';
import '../models/emotion_entry.dart';
import '../services/emotion_db_service.dart';

class EmotionProvider with ChangeNotifier {
  String? _selectedEmotion;
  List<EmotionEntry> _history = [];

  String? get selectedEmotion => _selectedEmotion;
  List<EmotionEntry> get history => _history;

  void selectEmotion(String emotion) {
    _selectedEmotion = emotion;
    notifyListeners();
  }

  Future<void> saveEmotionWithNote(String? note) async {
    if (_selectedEmotion == null) return;

    final entry = EmotionEntry(
      emotion: _selectedEmotion!,
      note: note,
      timestamp: DateTime.now(),
    );

    await EmotionDbService.insertEmotion(entry);
    _selectedEmotion = null;

    await loadHistory();
  }

  Future<void> loadHistory() async {
    _history = await EmotionDbService.getAllEmotions();
    notifyListeners();
  }

  Future<void> deleteAllHistory() async {
    await EmotionDbService.deleteAll();
    await loadHistory();
  }

  /// 🔥 ここを追加：日付ごとに感情をまとめた Map を返す
  Map<DateTime, List<EmotionEntry>> get emotionEvents {
    final Map<DateTime, List<EmotionEntry>> events = {};

    for (var entry in _history) {
      final date = DateTime(entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);
      events.putIfAbsent(date, () => []).add(entry);
    }

    return events;
  }
}
