class EmotionEntry {
  final int? id;
  final String emotion;
  final String? note;
  final DateTime timestamp;
  final String? tag; // ✅ 追加：タグ（学校・仕事など）

  EmotionEntry({
    this.id,
    required this.emotion,
    this.note,
    required this.timestamp,
    this.tag, // ✅ 追加
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emotion': emotion,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
      'tag': tag, // ✅ 追加
    };
  }

  factory EmotionEntry.fromMap(Map<String, dynamic> map) {
    return EmotionEntry(
      id: map['id'],
      emotion: map['emotion'],
      note: map['note'],
      timestamp: DateTime.parse(map['timestamp']),
      tag: map['tag'], // ✅ 追加
    );
  }

  EmotionEntry copyWith({
    int? id,
    String? emotion,
    String? note,
    DateTime? timestamp,
    String? tag, // ✅ 追加
  }) {
    return EmotionEntry(
      id: id ?? this.id,
      emotion: emotion ?? this.emotion,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      tag: tag ?? this.tag, // ✅ 追加
    );
  }
}
