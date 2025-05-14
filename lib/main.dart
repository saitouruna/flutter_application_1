import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/emotion_provider.dart'; // EmotionProviderをインポート

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmotionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Emotion Journal',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: themeProvider.primaryColor),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
