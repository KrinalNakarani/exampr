import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> checkDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, "rnw.db");
    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , price TEXT )";
      db.execute(query);
    });
  }

  Future<void> datainsert(String n1, String p1) async {
    db = await checkDatabase();
    db?.insert("product", {"name": n1, "price": p1});
  }

  Future<List<Map>> readData() async {
    db = await checkDatabase();
    String query = "SELECT * FROM product";
    List<Map> productList = await db!.rawQuery(query, null);
    return productList;
  }
}
