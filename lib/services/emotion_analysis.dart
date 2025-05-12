class EmotionAnalysisService {
  /// 感情に応じた提案を返す（今は簡易なルールベース）
  static List<String> getSuggestionsFromEmotion(String emotion) {
    switch (emotion) {
      case '嬉しい':
        return ['喜びを共有するメッセージを送る 😊', '好きな音楽をもっと聴こう 🎶'];
      case '悲しい':
        return ['感情を紙に書き出してみよう ✍️', '安心できる場所で一息つこう 🌿'];
      case '怒っている':
        return ['深呼吸して心を落ち着けよう 🌬️', '短い散歩でリフレッシュ 🚶‍♀️'];
      case '不安':
        return ['ゆったりした音楽を聴こう 🎧', '心配事を書き出して整理 📝'];
      case '楽しい':
        return ['写真を撮って思い出を残そう 📸', '友達とこの気分を共有しよう 👭'];
      default:
        return ['感情を記録して自分を知ろう 🧠'];
    }
  }
}
