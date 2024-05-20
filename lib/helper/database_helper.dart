import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');
    var theDb = await openDatabase(path, version: 22, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Users(id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, lastName TEXT, email TEXT, password TEXT, loggedIn INTEGER)',
    );
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 11) {
      await db.execute("ALTER TABLE Users ADD COLUMN firstName TEXT");
      await db.execute("ALTER TABLE Users ADD COLUMN lastName TEXT");
      await db.execute("ALTER TABLE Users ADD COLUMN email TEXT");
    }
  }

  Future<int> saveUser(String firstName, String lastName, String email, String password) async {
    var dbClient = await db;
    var result = await dbClient.insert("Users", {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'loggedIn': 0, // Initially set loggedIn to 0 (false)
    });
    return result;
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    var dbClient = await db;
    var result = await dbClient.query("Users",
        where: "email = ? AND password = ?", whereArgs: [email, password]);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var result = await dbClient.query("Users", where: 'loggedIn = ?', whereArgs: [1]);
    return result.isNotEmpty;
  }

  Future<void> updateUserLoggedInStatus(int id, int status) async {
    var dbClient = await db;
    await dbClient.update("Users", {'loggedIn': status}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> logout() async {
    var dbClient = await db;
    await dbClient.update("Users", {'loggedIn': 0}, where: 'loggedIn = ?', whereArgs: [1]);
  }
}
