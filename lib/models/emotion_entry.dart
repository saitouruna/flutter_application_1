class EmotionEntry {
  final String emotion;
  final String? note;
  final DateTime timestamp;

  EmotionEntry({
    required this.emotion,
    required this.timestamp,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'emotion': emotion,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory EmotionEntry.fromMap(Map<String, dynamic> map) {
    return EmotionEntry(
      emotion: map['emotion'],
      note: map['note'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
