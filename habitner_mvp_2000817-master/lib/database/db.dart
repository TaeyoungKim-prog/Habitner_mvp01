
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'data.dart';


final String TableName = 'datas';

class DBHelper {

  DBHelper();

  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'data_mvp.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE datas(dateTime TEXT PRIMARY KEY, sentences TEXT, checkList TEXT)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insertData(Data data) async {
    final db = await database;

    await db.insert(
      TableName,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복시
    );


  }

  Future<List<Data>> datas() async {
    final db = await database;

    //final List<Map<String, dynamic>> maps = await db.query('datas');
    final List<Map<String, dynamic>> maps = await db.query(TableName);

    return List.generate(maps.length, (i) {
      return Data(
        dateTime: interp_String_To_ListInt(maps[i]['dateTime']),
        sentences: interp_String_To_ListString(maps[i]['sentences']),
        checkList: interp_String_To_ListMap(maps[i]['checkList']),
      );
    });
  }

  Future<void> updateData(Data data) async {
    final db = await database;


    await db.update(
      TableName,
      data.toMap(),
      where: "dateTime = ?",
      whereArgs: [transToString_ListInt(data.dateTime)],
    );

  }

  Future<void> deleteData(List<int> dateTime) async {
    final db = await database;


    await db.delete(
      TableName,
      where: "dateTime = ?",
      whereArgs: [transToString_ListInt(dateTime)],
    );
  }


  Future<void> clearData() async {
    final db = await database;

    await db.delete(
        TableName
    );
  }

  Future<Data> findData (List<int> dateTime) async {

    final db = await database;


    final List<Map<String,dynamic>> maps = await db.query('datas', where: "dateTime = ?", whereArgs: [transToString_ListInt(dateTime)]);


    return Data(
      dateTime: interp_String_To_ListInt(maps[0]['dateTime']),
      sentences: interp_String_To_ListString(maps[0]['sentences']),
      checkList: interp_String_To_ListMap(maps[0]['checkList']),
    );
  }
}