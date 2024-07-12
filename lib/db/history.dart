import 'history_database.dart';
import 'history_model.dart';

class History {
  final HistoryDatabase _historyDatabase = HistoryDatabase.instance;

  Future<HistoryModel> createHistory(HistoryModel model) async {
    return await _historyDatabase.create(model);
  }

  Future<List<HistoryModel>> getAllHistories() async {
    return await _historyDatabase.findAll();
  }

  Future<HistoryModel> getHistoryById(int id) async {
    return await _historyDatabase.findById(id);
  }

  Future<List<HistoryModel>> getHistoriesByStatus(String status) async {
    return await _historyDatabase.findByStatus(status);
  }

  Future<int> updateHistory(HistoryModel model) async {
    return await _historyDatabase.update(model);
  }

  Future<int> deleteHistory(int id) async {
    return await _historyDatabase.delete(id);
  }
}

// Future<void> main () async {
//   final history = History();
//
//   // Creating
//   final model = HistoryModel(data: "HELLO WORLD", status: "GENERATED", createdAt: DateTime.now());
//   HistoryModel createdHistory = await history.createHistory(model);
//   print('createdHistory: ${createdHistory.id}');
//
//   // selecting all
//   List<HistoryModel> histories = await history.getAllHistories();
//   print('All Histories: ${histories.length}');
//
//   // Selecting by status
//   String status = 'INPUT';
//   List<HistoryModel> historiesByStatus = await history.getHistoriesByStatus(status);
//   print('Histories by Status: ${historiesByStatus.length}');
//
//   // Selecting by id
//   int id = createdHistory.id!;
//   HistoryModel historyById = await history.getHistoryById(id);
//   print('History by ID: ${historyById.data}');
//
//   // Updating
//   HistoryModel updatedHistory = historyById.copy(data: 'Updated Data');
//   await history.updateHistory(updatedHistory);
//   print('Updated History ID: $id');
//
//   // Deleting
//   await history.deleteHistory(id);
//   print('Deleted History ID: $id');
// }
