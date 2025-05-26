import 'package:flutter/material.dart';
import '../models/emotion_entry.dart'; // モデルファイルのパスは適宜調整
import '../services/emotion_db_service.dart'; // データベースサービス

class EmotionProvider extends ChangeNotifier {
  String? _selectedEmotion;
  final List<Map<String, dynamic>> _emotionRecords = [];

  String? get selectedEmotion => _selectedEmotion;
  List<Map<String, dynamic>> get emotionRecords =>
      List.unmodifiable(_emotionRecords);

  // データベースから取得した履歴
  List<EmotionEntry> _history = [];
  List<EmotionEntry> get history => _history;

  EmotionProvider() {
    loadHistory();
  }

  // 感情を選択
  void selectEmotion(String? emotion) {
    _selectedEmotion = emotion;
    notifyListeners();
  }

  // メモ付きで感情を保存（データベースに）
  Future<void> saveEmotionWithNote(String? note) async {
    if (_selectedEmotion == null) return;

    final now = DateTime.now();
    final entry = EmotionEntry(
      emotion: _selectedEmotion!,
      note: note,
      timestamp: now,
    );

    await EmotionDBService.insertEmotion(entry);
    _emotionRecords.add({
      'emotion': _selectedEmotion!,
      'timestamp': now,
    });

    _history.insert(0, entry); // メモ付き履歴に追加
    notifyListeners();
  }

  // 感情を記録（簡易な内部リストのみ）※既存処理
  void recordEmotion() {
    if (_selectedEmotion == null) return;

    final now = DateTime.now();
    _emotionRecords.add({
      'emotion': _selectedEmotion!,
      'timestamp': now,
    });

    notifyListeners();
  }

  // 記録をクリア（デバッグ用など）
  void clearRecords() {
    _emotionRecords.clear();
    notifyListeners();
  }

  // データベースから履歴を取得
  Future<void> loadHistory() async {
    _history = await EmotionDBService.getAllEmotions();
    notifyListeners();
  }

  /// 日付ごとの感情出現数を集計して返す
  Map<String, int> getEmotionCountByDate() {
    final Map<String, int> counts = {};

    for (var entry in _history) {
      final date =
          entry.timestamp.toLocal().toString().split(' ')[0]; // yyyy-MM-dd
      counts[date] = (counts[date] ?? 0) + 1;
    }

    return counts;
  }

  /// 感情ごとの出現回数を集計
  Map<String, int> getEmotionTypeCounts() {
    final Map<String, int> counts = {};

    for (var entry in _history) {
      final emotion = entry.emotion;
      counts[emotion] = (counts[emotion] ?? 0) + 1;
    }

    return counts;
  }

  /// 最新の感情エントリを返す（なければ null）
  EmotionEntry? get latestEmotion =>
      _history.isNotEmpty ? _history.first : null;

  //日付ごとの記録された感情一覧
  Map<DateTime, List<String>> get emotionEvents {
    final Map<DateTime, List<String>> events = {};

    for (var entry in _history) {
      final date = DateTime(
          entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);

      if (!events.containsKey(date)) {
        events[date] = [];
      }
      events[date]!.add(entry.emotion);
    }

    return events;
  }
}
