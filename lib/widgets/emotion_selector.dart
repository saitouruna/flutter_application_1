import 'package:flutter/material.dart';

class EmotionSelector extends StatefulWidget {
  final void Function(String emotion)? onEmotionSelected;

  const EmotionSelector({super.key, this.onEmotionSelected});

  @override
  State<EmotionSelector> createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector> {
  String? selectedEmotion;

  final List<Map<String, dynamic>> emotions = [
    {'emoji': '😄', 'label': '嬉しい', 'color': Colors.amber},
    {'emoji': '😢', 'label': '悲しい', 'color': Colors.blueAccent},
    {'emoji': '😡', 'label': '怒り', 'color': Colors.redAccent},
    {'emoji': '😰', 'label': '不安', 'color': Colors.deepPurple},
    {'emoji': '😌', 'label': '落ち着き', 'color': Colors.green},
    {'emoji': '😴', 'label': '疲れた', 'color': Colors.teal},
    {'emoji': '😍', 'label': '愛情', 'color': Colors.pinkAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: emotions.map((emotion) {
        final isSelected = selectedEmotion == emotion['label'];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedEmotion = emotion['label'];
            });
            if (widget.onEmotionSelected != null) {
              widget.onEmotionSelected!(emotion['label']);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  emotion['color'].withOpacity(0.7),
                  emotion['color'],
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: emotion['color'].withOpacity(0.6),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
              border: isSelected
                  ? Border.all(color: Colors.black87, width: 2)
                  : null,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emotion['emoji'], style: const TextStyle(fontSize: 36)),
                const SizedBox(height: 10),
                Text(
                  emotion['label'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(0.5, 0.5), blurRadius: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
