import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:edumarshal/models/user.dart';
import 'package:edumarshal/models/user_batch.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE User("
        "id INTEGER PRIMARY KEY, "
        "username TEXT, "
        "password TEXT ,"
        "accessToken TEXT,"
        "tokenType TEXT,"
        "xContextId TEXT,"
        "xRX TEXT)");
    await db.execute(
        "CREATE TABLE UserBatch("
            "batch TEXT)"
    );
    await db.execute(
        "CREATE TABLE BatchList("
            "id INTEGER PRIMARY KEY, "
            "BatchList TEXT, "
            "batch TEXT)"
    );
    //print("User tables Created");
  }

  Future<int> saveUser(LogedInUser logedInUser) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", logedInUser.toMap());
    if (res != null) {
      print(" User Data Insreted Into db");
    }
    return res;
  }

//  Future<int> saveUserBatch(UserBatch userBatch) async {
//    var dbClient = await db;
//    int res = await dbClient.insert("UserBatch", userBatch.userBatchMap());
//    if (res != null) {
//      print("User Batch response Data Insreted Into db");
//    }
//    return res;
//  }
  Future<int> saveBatchList(UserBatch userBatch) async {
    var dbClient = await db;
    int res = await dbClient.insert("BatchList", userBatch.batchListMap());
    if (res != null) {
      print("User BatchList Insreted Into db");
    }
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    if (res != null) {
      print("Data Dleted from db");
    }
    return res;
  }


  Future<bool> isExistingData(String tableName) async {
    var dbClient = await db;
    var res = await dbClient.query(tableName);

    return res.length > 0 ? true : false;
  }

  Future<List<Map>>getStoreData(String tableName) async {
    var dbClient = await db;
    return await dbClient.rawQuery("SELECT * FROM "+tableName);
  }
  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    return res.length > 0 ? true : false;
  }
}
