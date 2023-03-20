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
      // print(e);
      rethrow;
    }
  }

  Future<bool> writeItem({
    required String userId,
    // required String category,
    required Map<String, dynamic> data,
  }) async {
    try {
      // print(userId);
      // print(data);
      // print(category);
      String itemName = data['name'];
      String category = data['category'];
      DatabaseReference _databaseReference =
          database.ref("users/$userId/inventory");
      // final newItemRef = _databaseReference.child(category).push();
      final newItemRef = _databaseReference.push();
      bool result = await checkItemByName(
          userId: userId, category: category, itemName: itemName);
      if (result == false) {
        await newItemRef.update(data);
        return Future.value(true);
      } else {
        return Future.value(false);
      }

      // await newItemRef.update(data);
      // await _databaseReference.update(data);
    } catch (e) {
      // print(e);
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

  Future<bool> updateItem(
      {required String userId,
      // required String category,
      required String itemID,
      required int quantity}) async {
    try {
      // print(userId);
      // print(data);
      // print(category);
      // String itemName = data['name'];
      // String category = data['category'];
      // DatabaseReference _databaseReference =
      //     database.ref("users/$userId/inventory");
      DatabaseReference _databaseReference =
          database.ref("users/$userId/inventory/$itemID");

      await _databaseReference.update({"quantity": quantity});
      print("Item quantity updated successfully!");
      return Future.value(true); // return a boolean value to indicate success
    } catch (e) {
      // print(e);
      print("Error updating item quantity: $e");
      rethrow;
    }
  }

  Future<bool> updateFav(
      {required String userId,
      // required String category,
      required String itemID,
      required bool favorite}) async {
    try {
      // print(userId);
      // print(data);
      // print(category);
      // String itemName = data['name'];
      // String category = data['category'];
      // DatabaseReference _databaseReference =
      //     database.ref("users/$userId/inventory");
      DatabaseReference _databaseReference =
          database.ref("users/$userId/inventory/$itemID");

      await _databaseReference.update({"favorite": favorite});
      print("Item favorite updated successfully!");
      return Future.value(true); // return a boolean value to indicate success
    } catch (e) {
      // print(e);
      print("Error updating item favorite: $e");
      rethrow;
    }
  }

  Future<Map?> itemsbyCategory({
    required String userId,
    required String category,
  }) async {
    try {
      DatabaseReference _databaseReference =
          database.ref("users/$userId").child("inventory");
      // final listOfitem = _databaseReference.child(category);
      final filteredItemsRef =
          _databaseReference.orderByChild('category').equalTo(category);
      // print(listOfitem.get());
      final snapshot = await filteredItemsRef.get();
      if (snapshot.exists) {
        // Map<dynamic, dynamic> data = {};
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        // _snapshotValue.forEach((key, value) {
        //   print(key);
        //   print(value);
        // });

        return _snapshotValue;
      } else {
        // print("null");
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map?> getAllItems({
    required String userId,
  }) async {
    try {
      DatabaseReference _databaseReference =
          database.ref("users/$userId").child("inventory");
      // final listOfitem = _databaseReference.child(category);

      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        // Map<dynamic, dynamic> data = {};
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        // _snapshotValue.forEach((key, value) {
        //   print(key);
        //   print(value);
        // });

        return _snapshotValue;
      } else {
        // print("null");
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkItemByName({
    required String userId,
    required String category,
    required String itemName,
  }) async {
    try {
      DatabaseReference _databaseReference =
          database.ref("users/$userId/inventory");
      // final listOfitem = _databaseReference.child(category);
      // DataSnapshot data = await listOfitem.get();
      // print(data.value);
// Run the query and check if there are any results

      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        bool itemFound = false;
        _snapshotValue.forEach((key, value) {
          // print(key);

          value.forEach((key, value) {
            // print(value);
            if (value == itemName) {
              // print(value);
              itemFound = true;
            }
          });
        });
        // print(Future.value(itemFound));
        return Future.value(itemFound);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      // print(e.toString());
      // return Future.value(true);
      rethrow;
    }
  }

  Future<Map?> getItemByID({
    required String userId,
    required String itemID,
  }) async {
    try {
      DatabaseReference _databaseReference =
          database.ref("users/$userId/inventory");
      // final listOfitem = _databaseReference.child(category);
      // DataSnapshot data = await listOfitem.get();
      // print(data.value);
// Run the query and check if there are any results

      final snapshot = await _databaseReference.get();

      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        if (_snapshotValue.containsKey(itemID)) {
          print(_snapshotValue);

          return _snapshotValue[itemID];
        } else {
          return null;
        }
      }
      //   _snapshotValue.forEach((key, value) {
      //     // print(key);
      //     if (key == itemID) {
      //       return
      //     }
      //     // value.forEach((key, value) {
      //     //   // print(value);
      //     //   if (value == itemName) {
      //     //     // print(value);
      //     //     itemFound = true;
      //     //   }
      //     // });
      //   });
      //   // print(Future.value(itemFound));
      //   return Future.value(itemFound);
      // } else {
      //   return Future.value(false);
      // }
    } catch (e) {
      // print(e.toString());
      // return Future.value(true);
      rethrow;
    }
  }

  Future<bool> deleteItem({
    required String userId,
    // required String category,
    required String itemID,
  }) async {
    try {
      // print(userId);
      // print(data);
      // print(category);
      // String itemName = data['name'];
      // String category = data['category'];
      // DatabaseReference _databaseReference =
      //     database.ref("users/$userId/inventory");
      DatabaseReference _databaseReference =
          database.ref("users/$userId/inventory/$itemID");
      await _databaseReference.remove();
      print("Item deleted successfully!");
      return Future.value(true); // return a boolean value to indicate success
    } catch (e) {
      // print(e);
      print("Error updating item quantity: $e");
      rethrow;
    }
  }
}
