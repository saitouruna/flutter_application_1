// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'emotion_record_screen.dart'; // EmotionRecordScreenのインポート
import 'suggestion_screen.dart'; // SuggestionsScreenのインポート

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // ボタンが押された時にEmotionRecordScreenへ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmotionRecordScreen()),
                );
              },
              child: const Text('感情を記録する'),
            ),
            const SizedBox(height: 20), // ボタンの間隔を空ける
            ElevatedButton(
              onPressed: () {
                // ボタンが押された時にSuggestionsScreenへ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuggestionScreen()),
                );
              },
              child: const Text('提案を受け取る'),
            ),
          ],
        ),
      ),
    );
  }
}
