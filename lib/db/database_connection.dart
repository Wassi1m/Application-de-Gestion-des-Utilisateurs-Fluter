import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  // Singleton
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  factory DatabaseConnection() => _instance;
  DatabaseConnection._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');

    return await openDatabase(
      path,
      version: 2, // Version 2 pour inclure la colonne image
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql = '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        contact TEXT,
        description TEXT,
        image TEXT
      )
    ''';
    await database.execute(sql);
  }
}

