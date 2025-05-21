import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emotion_provider.dart';
import '../providers/theme_provider.dart';
import 'emotion_record_screen.dart';
import 'suggestion_screen.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final emotionProvider =
          Provider.of<EmotionProvider>(context, listen: false);
      emotionProvider.loadHistory(); // ここで async は OK（この関数内で async にする）
    });
  }

  @override
  Widget build(BuildContext context) {
    final emotionProvider = Provider.of<EmotionProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('感情ジャーナル'),
        backgroundColor: themeProvider.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '今日の感情',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: themeProvider.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: emotionProvider.selectedEmotion != null
                  ? Row(
                      children: [
                        const Icon(Icons.emoji_emotions, size: 32),
                        const SizedBox(width: 10),
                        Text(
                          emotionProvider.selectedEmotion!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    )
                  : const Text(
                      'まだ感情が記録されていません。',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 30),
            const Text(
              '次のアクション',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('感情を記録する'),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const EmotionRecordScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.lightbulb),
              label: const Text('気分に合った提案を見る'),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SuggestionsScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text('記録履歴を見る'),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
