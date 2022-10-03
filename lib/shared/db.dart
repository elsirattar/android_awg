// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MySql {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initializeDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'awg.db');

    Database myDb = await openDatabase(path, version: 1, onCreate: _onCreate);

    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE 'item'('id' INTEGER PRIMARY KEY,
        'name' TEXT NOT NULL, 'count' REAL NOT NULL,
         'item_cost' REAL NOT NULL, 'itemSellPrice' REAL NOT NULL,
          'code' TEXT)

    """);

    await db.execute(
        """CREATE TABLE "daily_sales"('id' INTEGER PRIMARY KEY, "count" REAL NOT NULL,
         "item_name", "price" REAL NOT NULL, "total" REAL NOT NULL, "invoice" TEXT NOT NULL ,
         "item_id" int NOT NULL, "date" Text NOT NULL
         )""");
    print('db created');
    return db;
  }

  readDate(String sql) async {
    Database? myDatabase = await db;
    var response = await myDatabase!.rawQuery(sql);
    return response;
  }

  insertDate(String sql) async {
    Database? myDatabase = await db;
    int response = await myDatabase!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDatabase = await db;
    int response = await myDatabase!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDatabase = await db;
    int response = await myDatabase!.rawInsert(sql);
    return response;
  }
}
