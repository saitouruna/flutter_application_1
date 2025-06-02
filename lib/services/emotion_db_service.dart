import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/emotion_entry.dart';

class EmotionDbService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('emotion.db');
    return _database!;
  }

  static Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE emotions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            emotion TEXT NOT NULL,
            note TEXT,
            timestamp TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> insertEmotion(EmotionEntry entry) async {
    final db = await database;
    return await db.insert('emotions', entry.toMap());
  }

  static Future<List<EmotionEntry>> getAllEmotions() async {
    final db = await database;
    final maps = await db.query('emotions', orderBy: 'timestamp DESC');
    return maps.map((map) => EmotionEntry.fromMap(map)).toList();
  }

  static Future<void> deleteAll() async {
    final db = await database;
    await db.delete('emotions');
  }
}
