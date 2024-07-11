import 'package:flutter_base_project/db/history_field.dart';
import 'package:flutter_base_project/db/history_model.dart';
import 'package:sqflite/sqflite.dart';

class HistoryDatabase {
  static final HistoryDatabase instance = HistoryDatabase._internal();
  static Database? _database;

  HistoryDatabase._internal();

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
    CREATE TABLE IF NOT EXISTS ${HistoryField.tableName} (
	    ${HistoryField.id}	${HistoryField.idType},
	    ${HistoryField.data}	${HistoryField.dataType},
	    ${HistoryField.createdAt}	${HistoryField.createdAtType},
	    ${HistoryField.status} ${HistoryField.statusType},
    )
    ''');
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/history.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<HistoryModel> create(HistoryModel model) async {
    final db = await instance.database;
    final id = await db.insert(HistoryField.tableName, model.toJson());
    return model.copy(id: id);
  }

  Future<List<HistoryModel>> findAll() async {
    final db = await instance.database;
    final maps = await db.query(
      HistoryField.tableName,
      columns: HistoryField.values,
      orderBy: '${HistoryField.createdAt} DESC',
    );
    return maps.map((json) => HistoryModel.fromJson(json)).toList();
  }

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

  Future<int> update(HistoryModel model) async {
    final db = await instance.database;
    return db.update(
      HistoryField.tableName,
      model.toJson(),
      where: '${HistoryField.id} = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      HistoryField.tableName,
      where: '${HistoryField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
