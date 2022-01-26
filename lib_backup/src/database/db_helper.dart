import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../common/app_constant.dart';
import '../model/note.dart';
 
class DbHelper {
  static Database? _database;

  static Future<void> init() async {
    Directory? directory = await getExternalStorageDirectory();
    _database = await openDatabase(
      join(directory?.path ?? '', AppConstant.dbName),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE ${AppConstant.tableName} ('
          '${AppConstant.fId} INTEGER PRIMARY KEY AUTOINCREMENT, '
          '${AppConstant.fContent} TEXT'
          ')',
        );
      },
    );
  }

  static Future<int?> createData(Note note) async {
    return await _database?.insert(
      AppConstant.tableName,
      note.toMap(),
    );
  }

  static Future<List<Note>> readData() async {
    List<Map<String, Object?>>? data = await _database?.query(
      AppConstant.tableName,
    );
    List<Note> notes = <Note>[];
    if (data == null) return notes;
    for (Map<String, Object?> item in data) {
      notes.add(Note.fromMap(item));
    }
    return notes;
  }

  static Future<int?> updateData(Note note) async {
    return await _database?.update(
      AppConstant.tableName,
      note.toMap(),
      where: '${AppConstant.fId} = ?',
      whereArgs: <Object?>[note.id],
    );
  }

  static Future<int?> deleteData(int id) async {
    return await _database?.delete(
      AppConstant.tableName,
      where: '${AppConstant.fId} = ?',
      whereArgs: <Object?>[id],
    );
  }
}
