import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  void writeUser({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      // print(userId);
      // print(data);
      DatabaseReference _databaseReference = database.ref("users/$userId");

      await _databaseReference.set(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void writeItem({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      // print(userId);
      // print(data);
      DatabaseReference _databaseReference = database.ref("users/$userId");

      await _databaseReference.set(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> read({required String userId}) async {
    try {
      DatabaseReference _databaseReference = database.ref("users/$userId");
      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        return _snapshotValue['name'] ?? '';
      } else {
        return '';
      }
    } catch (e) {
      rethrow;
    }
  }
}
