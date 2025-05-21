import 'dart:io'; // ← Platform判定に必要
import 'package:flutter/foundation.dart' show kIsWeb; // Web判定に必要
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // ← 追加

import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/emotion_provider.dart'; // EmotionProviderをインポート

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // デスクトップ対応の初期化（Web以外、Windows/Linux/macOS のとき）
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

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
