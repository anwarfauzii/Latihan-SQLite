import 'dart:io';

import '../db/db.dart';
import '../model/database_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


 
class DbHelper {
  static Database? _database;

  static Future<void> init() async {
    Directory? directory = await getExternalStorageDirectory();
    _database = await openDatabase(
      join(directory?.path ?? '', DatabaseLokal.dbName),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE ${DatabaseLokal.tableName} ('
          '${DatabaseLokal.id} INTEGER PRIMARY KEY AUTOINCREMENT, '
          '${DatabaseLokal.fullname} TEXT'
          ')',
        );
      },
    );
  }

  static Future<int?> createData(DatabaseModel databaseModel) async {
    return await _database?.insert(
      DatabaseLokal.tableName,
      databaseModel.toJson(),
    );
  }

  static Future<List<DatabaseModel>> readData() async {
    List<Map<String, Object?>>? data = await _database?.query(
      DatabaseLokal.tableName,
    );
    List<DatabaseModel> notes = <DatabaseModel>[];
    if (data == null) return notes;
    for (Map<String, Object?> item in data) {
      notes.add(DatabaseModel.fromJson(item));
    }
    return notes;
  }

  static Future<int?> updateData(DatabaseModel note) async {
    return await _database?.update(
      DatabaseLokal.tableName,
      note.toJson(),
      where: '${DatabaseLokal.id} = ?',
      whereArgs: <Object?>[note.id],
    );
  }

  static Future<int?> deleteData(int id) async {
    return await _database?.delete(
      DatabaseLokal.tableName,
      where: '${DatabaseLokal.id} = ?',
      whereArgs: <Object?>[id],
    );
  }
}
