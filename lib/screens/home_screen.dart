// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'emotion_record_screen.dart'; // EmotionRecordScreenのインポート
import 'suggestion_screen.dart';
 //SuggestionsScreenのインポート

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('感情ジャーナル'),
	      backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
 		          style: ElevatedButton.styleFrom(
			          backgroundColor: Colors.orangeAccent,
			          foregroundColor: Colors.white,
            		padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            	),

		          onPressed: (){
			          Navigator.push(
				          context,
				          MaterialPageRoute(builder: (context) =>  EmotionRecordScreen()),
			          );
		          },
		          child: const Text('感情を記録する'),
            ),
            const SizedBox(height: 20), // ボタンの間隔を空ける
            ElevatedButton(
	          style: ElevatedButton.styleFrom(
			        backgroundColor: Colors.teal,
			        foregroundColor: Colors.white,
			        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
	          ),
            onPressed: () {
                // ボタンが押された時にSuggestionsScreenへ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuggestionsScreen()),

                );
              },
              child: const Text('おすすめを見る'),
            ),
          ],
        ),
      ),
    );
  }
}
