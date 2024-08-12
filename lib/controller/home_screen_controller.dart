import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map> myDataList = [];

  static Future<void> initDB() async {
    // open the database
    database = await openDatabase("myDb.db", version: 1, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

// to add a data to database table
  static Future<void> addData({required String name, required String des}) async {
    await database.rawInsert('INSERT INTO Employees(name, designation) VALUES(?, ?)', [name, des]);
    getData();
  }

// to get all data form database table
  static Future<void> getData() async {
    List<Map> list = await database.rawQuery('SELECT * FROM Employees');
    myDataList = list;
  }
}
