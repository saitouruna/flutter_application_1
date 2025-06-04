class EmotionEntry {
  final int? id;
  final String emotion;
  final String? note;
  final DateTime timestamp;

  EmotionEntry({
    this.id,
    required this.emotion,
    this.note,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emotion': emotion,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory EmotionEntry.fromMap(Map<String, dynamic> map) {
    return EmotionEntry(
      id: map['id'],
      emotion: map['emotion'],
      note: map['note'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  /// ✅ これを追加
  EmotionEntry copyWith({
    int? id,
    String? emotion,
    String? note,
    DateTime? timestamp,
  }) {
    return EmotionEntry(
      id: id ?? this.id,
      emotion: emotion ?? this.emotion,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
