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

  /// 新規記録の保存（EmotionEntry を直接渡す）
  Future<void> saveEmotionWithNote(EmotionEntry entry) async {
    await EmotionDbService.insertEmotion(entry);
    _selectedEmotion = null;
    await loadHistory();
  }

  /// ID付きの既存レコードを更新
  Future<void> updateEmotion(EmotionEntry entry) async {
    await EmotionDbService.updateEmotion(entry);
    await loadHistory();
  }

  /// 一覧をロード（降順）
  Future<void> loadHistory() async {
    _history = await EmotionDbService.getAllEmotions();
    notifyListeners();
  }

  Future<void> deleteAllHistory() async {
    await EmotionDbService.deleteAll();
    await loadHistory();
  }

  /// 日付ごとにまとめるマップ形式（カレンダー用）
  Map<DateTime, List<EmotionEntry>> get emotionEvents {
    final Map<DateTime, List<EmotionEntry>> events = {};
    for (var entry in _history) {
      final date = DateTime(entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);
      events.putIfAbsent(date, () => []).add(entry);
    }
    return events;
  }

  /// 単体記録を追加
  Future<void> addEmotion(EmotionEntry entry) async {
    await EmotionDbService.insertEmotion(entry);
    await loadHistory(); // データを再取得して更新通知
  }

  /// 🔥 単体記録を削除（id 必須）
  Future<void> deleteEmotion(EmotionEntry entry) async {
    if (entry.id == null) return;
    await EmotionDbService.deleteEmotion(entry.id!);
    await loadHistory();
  }
}
