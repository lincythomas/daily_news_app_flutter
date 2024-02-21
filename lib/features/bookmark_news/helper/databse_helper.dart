import 'package:daily_news_app/model/bookmark_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static DataBaseHelper? _dataBaseHelper;
  static Database? _database;
  static const _databaseVersion = 1;
  String bookmarksTable = "bookmarks";

  DataBaseHelper._createInstance();
  factory DataBaseHelper() {
    _dataBaseHelper ??= DataBaseHelper._createInstance();
    return _dataBaseHelper!;
  }

  Future<Database> get database async {
    return _database ??= await _initializeDatabase();
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), "news_bookmarks.db"),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $bookmarksTable(id INTEGER PRIMARY KEY, title TEXT, description TEXT, imageUrl TEXT, publishedAt TEXT, content TEXT, author TEXT)');
    }, version: _databaseVersion);
  }

  Future<int> insertArticle(BookMarkData bookMarkData) async {
    Database db = await database;

    var result = await db.insert(bookmarksTable, bookMarkData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int> deleteArticle(int id) async {
    Database db = await database;
    return await db.delete(bookmarksTable, where: 'id = ?', whereArgs: [id]);
  }

  // Future<List<BookMarkData>> fetchBookMarks() async {
  //   Database db = await database;
  //   var maps = await db.query(bookmarksTable);
  //   return List.generate(
  //       maps.length,
  //       (index) => BookMarkData(
  //           id: maps[index]["id"] as int,
  //           title: maps[index]["title"] as String,
  //           description: maps[index]["description"] as String,
  //           imageUrl: maps[index]["imageUrl"] as String,
  //           publishedAt: maps[index]["publishedAt"] as String,
  //           content: maps[index]["content"] as String,
  //           author: maps[index]['author'] as String));
  // }
  Stream<List<BookMarkData>> fetchBookMarks() async* {
    Database db = await database;
    var maps = await db.query(bookmarksTable);
    var list = List.generate(
        maps.length,
        (index) => BookMarkData(
            id: maps[index]["id"] as int,
            title: maps[index]["title"] as String,
            description: maps[index]["description"] as String,
            imageUrl: maps[index]["imageUrl"] as String,
            publishedAt: maps[index]["publishedAt"] as String,
            content: maps[index]["content"] as String,
            author: maps[index]['author'] as String));
    yield list;
  }
}
