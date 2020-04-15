import 'dart:async';
import 'dart:io';
import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:path/path.dart';
class NewsDbProvider implements Source, Cache{
  Database db;

  NewsDbProvider (){
    init();
  }
  void init() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
      onCreate: (Database newDb, int version){
        newDb.execute("""
            CREATE TABLE Items 
            (
              id INTEGER PRIMARY KEY,
              title TEXT,
              by TEXT,
              type TEXT,
              text TEXT,
              parent INTEGER,
              dead INTEGER,
              time INTEGER,
              kids BLOB,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              descendants INTEGER
            )
            """);
      });
  }
  Future<List<int>> fetchTopIds(){
    // TODO store and fetch top ids
    return null;
  }
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id]
    );
    if(maps.length>1){
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel itemModel) {
    return db.insert(
        "Items",
        itemModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore
    );

  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();