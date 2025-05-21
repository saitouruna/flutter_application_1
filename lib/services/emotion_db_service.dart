import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/emotion_entry.dart';

class EmotionDBService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'emotion_journal.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE emotions(
            id INTEGER PRIMARY KEY,
            emotion TEXT,
            note TEXT,
            timestamp TEXT
          )
          '''
        );
      },
    );
  }

  static Future<void> insertEmotion(EmotionEntry entry) async {
    final db = await database;
    await db.insert('emotions', entry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<EmotionEntry>> getAllEmotions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('emotions', orderBy: 'timestamp DESC');
    return List.generate(maps.length, (i) => EmotionEntry.fromMap(maps[i]));
  }

  static Future<void> deleteAll() async {
    final db = await database;
    await db.delete('emotions');
  }
}
