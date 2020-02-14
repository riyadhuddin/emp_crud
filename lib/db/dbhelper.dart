import 'package:emp_crud/model/person.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
//import 'dart:io';
import 'package:path/path.dart';
class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();//io.Directory
    String path = join(documentsDirectory.path, "test2.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Employee(id INTEGER PRIMARY KEY, name TEXT, age TEXT, height TEXT, mobileno Text)");
    print("Created tables");
  }

  // Retrieving employees from Employee Tables
  Future<List<Person>> getEmployees() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
    List<Person> employees = new List();
    for (int i = 0; i < list.length; i++) {
      employees.add(
          new Person(list[i]["name"], list[i]["age"], list[i]["height"], list[i]["mobileno"]));
    }
    print(employees.length);
    return employees;
  }

  void saveEmployee(Person person) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      var query = 'INSERT INTO Employee (name, age, height, mobileno) VALUES (' +
          '\'' +
          person.name +
          '\'' +
          ',' +
          '\'' +
          person.age +
          '\'' +
          ',' +
          '\'' +
           person.height +
          '\'' +
          ',' +
          '\'' +
          person.mobileNo +
          '\'' +
          ")";
      print("Query : " + query);
      return await txn.rawInsert(query);
    });
  }
}