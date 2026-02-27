import 'package:mon_projet/db/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  final DatabaseConnection _databaseConnection = DatabaseConnection();

  // Insérer un enregistrement dans une table
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final Database db = await _databaseConnection.database;
    return await db.insert(table, data);
  }

  // Lire tous les enregistrements d'une table
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final Database db = await _databaseConnection.database;
    return await db.query(table);
  }

  // Lire un enregistrement par ID
  Future<List<Map<String, dynamic>>> getById(String table, int id) async {
    final Database db = await _databaseConnection.database;
    return await db.query(table, where: 'id = ?', whereArgs: [id]);
  }

  // Mettre à jour un enregistrement
  Future<int> update(String table, Map<String, dynamic> data) async {
    final Database db = await _databaseConnection.database;
    return await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  // Supprimer un enregistrement par ID
  Future<int> delete(String table, int id) async {
    final Database db = await _databaseConnection.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}

