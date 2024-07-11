import 'package:flutter_base_project/db/history_field.dart';

class HistoryModel {
  final int? id;
  final String data;
  final String status;
  final DateTime? createdAt;

  HistoryModel({
    this.id,
    required this.data,
    required this.status,
    this.createdAt,
  });

  Map<String, Object?> toJson() => {
        HistoryField.id: id,
        HistoryField.data: data,
        HistoryField.status: status,
        HistoryField.createdAt: createdAt?.toIso8601String(),
      };

  HistoryModel copy({
    int? id,
    String? data,
    String? status,
    DateTime? createdAt,
  }) =>
      HistoryModel(
        id: id ?? this.id,
        data: data ?? this.data,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  factory HistoryModel.fromJson(Map<String, Object?> json) => HistoryModel(
        id: json[HistoryField.id] as int?,
        data: json[HistoryField.data] as String,
        status: json[HistoryField.status] as String,
        createdAt:
            DateTime.tryParse(json[HistoryField.createdAt] as String? ?? ''),
      );
}
