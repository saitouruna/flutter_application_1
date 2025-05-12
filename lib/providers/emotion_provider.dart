import 'package:flutter/material.dart';

class EmotionProvider extends ChangeNotifier {
  String? _selectedEmotion;
  final List<Map<String, dynamic>> _emotionRecords = [];

  String? get selectedEmotion => _selectedEmotion;
  List<Map<String, dynamic>> get emotionRecords => List.unmodifiable(_emotionRecords);

  // 感情を選択
  void selectEmotion(String emotion) {
    _selectedEmotion = emotion;
    notifyListeners();
  }

  // 感情を記録（日付と一緒に）
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
}
