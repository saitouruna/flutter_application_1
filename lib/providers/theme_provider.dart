import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color _primaryColor = const Color(0xFFE0BBE4);

  Color get primaryColor => _primaryColor;

  ThemeData get themeData => ThemeData(
        primarySwatch: createMaterialColor(_primaryColor),
        useMaterial3: true,
      );

  // 🔽 このメソッドを追加します
  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }

  // 既存の createMaterialColor ヘルパー関数
  MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
