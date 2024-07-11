class HistoryField {
  static const String tableName = 'history';
  static const String id = '_id';
  static const String data = 'data';
  static const String status = 'status';
  static const String createdAt = 'created_at';

  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String dataType = 'TEXT NOT NULL';
  static const String statusType = "TEXT NOT NULL CHECK('type' IN ('SCANNED', 'GENERATED'))";
  static const String createdAtType = 'DATETIME NOT NULL';

  static const List<String> values = [
    id,
    data,
    status,
    createdAt,
  ];
}
