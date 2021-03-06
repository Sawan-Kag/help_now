import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sigma_tenat/dataModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'data_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE data('
          '_id TEXT,'
          'title TEXT,'
          'displayName TEXT,'
          'meta TEXT,'
          'description TEXT'
          ')');
    });
  }

  // Insert dta on database
  createdata(Data newdata) async {
    await deleteAlldata();
    final db = await database;
    final res = await db.insert('data', newdata.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAlldata() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM data');

    return res;
  }

  Future<List<Data>> getAlldatafromdatabase() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM data");

    List<Data> list =
        res.isNotEmpty ? res.map((c) => Data.fromJson(c)).toList() : [];

    return list;
  }
}
