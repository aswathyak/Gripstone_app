import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'data_model.dart';

class DB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "MYDb.db"),
      onCreate: (database, verison) async {
        await database.execute("""
        CREATE TABLE MYTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        subtitle TEXT NOT NULL
        )
        """);
      },
      version: 1,
    );
  }

  Future<bool> insertData(DataModel dataModel) async {
    final Database db = await initDB();
    db.insert("MYTable", dataModel.toMap());
    return true;
  }

  Future<void> update(DataModel dataModel, int id) async {
    final Database db = await initDB();
    await db
        .update("MYTable", dataModel.toMap(), where: "id=?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final Database db = await initDB();
    await db.delete("MYTable", where: "id=?", whereArgs: [id]);
  }

  Future<List<DataModel>> getData() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("MYTable");
    return datas.map((e) => DataModel.fromMap(e)).toList();
  }
}
