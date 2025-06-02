import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// デスクトップ向け sqflite_common_ffi をインポート
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/emotion_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Web以外のデスクトップでは FFI を初期化
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
