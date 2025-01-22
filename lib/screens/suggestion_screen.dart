// lib/screens/suggestions_screen.dart
import 'package:flutter/material.dart';

class SuggestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestions Screen'),
      ),
      body: const Center(
        child: Text('Here you can get suggestions based on your mood!'),
      ),
    );
  }
}
