import 'package:flutter_base_project/db/history_field.dart';
import 'package:flutter_base_project/db/history_model.dart';
import 'package:sqflite/sqflite.dart';

/// Class to manage the history database
class HistoryDatabase {
  /// Singleton instance of the HistoryDatabase class
  static final HistoryDatabase instance = HistoryDatabase._internal();

  /// Instance of the database
  static Database? _database;

  /// Private constructor to implement the singleton pattern
  HistoryDatabase._internal();

  /// Creates the history table in the database if it does not exist
  ///
  /// @param db The database
  /// @param version The version of the database
  /// @return Future<void>
  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
    CREATE TABLE IF NOT EXISTS ${HistoryField.tableName} (
      ${HistoryField.id} ${HistoryField.idType},
      ${HistoryField.data} ${HistoryField.dataType},
      ${HistoryField.createdAt} ${HistoryField.createdAtType},
      ${HistoryField.status} ${HistoryField.statusType}
    )
    ''');
  }

  /// Initializes and opens the database
  ///
  /// @return Future<Database> The instance of the database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/history.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  /// Gets the instance of the database
  ///
  /// @return Future<Database> The instance of the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  /// Inserts a new record into the database
  ///
  /// @param model The history model to insert
  /// @return Future<HistoryModel> The history model with the generated ID
  Future<HistoryModel> create(HistoryModel model) async {
    final db = await instance.database;
    final id = await db.insert(HistoryField.tableName, model.toJson());
    return model.copy(id: id);
  }

  /// Retrieves all history records from the database
  ///
  /// @return Future<List<HistoryModel>> A list of all history models
  Future<List<HistoryModel>> findAll() async {
    final db = await instance.database;
    final maps = await db.query(
      HistoryField.tableName,
      columns: HistoryField.values,
      orderBy: '${HistoryField.createdAt} DESC',
    );
    return maps.map((json) => HistoryModel.fromJson(json)).toList();
  }

  /// Retrieves a history record by its ID
  ///
  /// @param id The ID of the history record
  /// @return Future<HistoryModel> The history model with the specified ID
  /// @throws Exception if the ID is not found
  Future<HistoryModel> findById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      HistoryField.tableName,
      columns: HistoryField.values,
      where: '${HistoryField.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return HistoryModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  /// Retrieves history records by their status
  ///
  /// @param status The status of the history records
  /// @return Future<List<HistoryModel>> A list of history models with the specified status
  Future<List<HistoryModel>> findByStatus(String status) async {
    final db = await instance.database;
    final maps = await db.query(
      HistoryField.tableName,
      columns: HistoryField.values,
      where: '${HistoryField.status} = ?',
      whereArgs: [status],
    );
    return maps.map((json) => HistoryModel.fromJson(json)).toList();
  }

  /// Updates an existing history record in the database
  ///
  /// @param model The history model to update
  /// @return Future<int> The number of rows affected
  Future<int> update(HistoryModel model) async {
    final db = await instance.database;
    return db.update(
      HistoryField.tableName,
      model.toJson(),
      where: '${HistoryField.id} = ?',
      whereArgs: [model.id],
    );
  }

  /// Deletes a history record by its ID
  ///
  /// @param id The ID of the history record to delete
  /// @return Future<int> The number of rows affected
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      HistoryField.tableName,
      where: '${HistoryField.id} = ?',
      whereArgs: [id],
    );
  }

  /// Closes the database connection
  ///
  /// @return Future<void>
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
