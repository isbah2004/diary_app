import 'package:diary_app/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesRepository {
  static const dbName = 'notes_database.db';
  static const tableName = 'notes';
  static Future<Database> database() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'dbName'),
      onCreate: (db, version) {
        return db.execute(
            'Create Table $tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT)');
      },
      version: 1,
    );
    return database;
  }

  static insert({required Note note}) async {
    final db = await database();
    await db.insert(
      tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static getNotes() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Note(
          title: maps[i]['title'].toString(),
          description: maps[i]['description'].toString(),
          createdAt: DateTime.parse(maps[i]['createdAt']),
          id: maps[i]['id'] as int);
    });
  }

  static update({required Note note}) async {
    final db = await database();
    await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
  static delete({required Note note}) async {
    final db = await database();
    await db.delete(
      tableName,
      
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
