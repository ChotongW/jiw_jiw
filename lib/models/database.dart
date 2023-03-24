// -----------------------------------------------------------------------------
// database.dart
// -----------------------------------------------------------------------------
//
// This header file contains functions for efficiently connect with firebase realtime database.
// for easily to use we crate class DatabaseService.

import 'package:firebase_database/firebase_database.dart';

// -----------------------------------------------------------------------------
// DatabaseService
// -----------------------------------------------------------------------------
//
// The DatabaseService class is create firebase database instance
// for CRUD operations in firebase real time database
// we use this class as model for database part
class DatabaseService {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  // writeUser(userId,data)
  // this function crate user profile from register.
  // required string userId and Map of data that from profile model.

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

  // writeItem(userId,data)
  // this function crate item profile that invoke from addItem.dart.
  // required string userId and Map of data that from item model.
  // before crate we must invoke checkItemByName
  // for prevent data redundunt
  // return status of created item

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

  // old feature
  // Future<String> read({required String userId}) async {
  //   try {
  //     DatabaseReference _databaseReference = database.ref("users/$userId");
  //     final snapshot = await _databaseReference.get();
  //     if (snapshot.exists) {
  //       Map<String, dynamic> _snapshotValue =
  //           Map<String, dynamic>.from(snapshot.value as Map);
  //       return _snapshotValue['name'] ?? '';
  //     } else {
  //       return '';
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // updateItem(userId,itemID,quantity)
  // this function update item data in database that invoke from search.dart.
  // required string userId and itemID and int quality.
  // return status of updated item
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

  // updateFav(userId,itemID,favorite)
  // this function update item favorite data in database that invoke from search.dart.
  // required string userId and itemID and bool favorite.
  // return status of updated item
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

  // itemsbyCategory(userId,itemID)
  // this function search items data that filter by category in database that invoke from search.dart.
  // required string userId and category.
  // return Map of item that filter by category
  // if not have data return null
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

  // getAllItems(userId)
  // this function search all items in database that invoke from search.dart.
  // required string userId.
  // return Map of all item.
  // if not have data return null
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

  // checkItemByName(userId,category,itemName)
  // this function search for item have this name in database that invoke from database.dart.
  // required string userId, category,and itemName.
  // return status that found item or not.

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

  // getItemByID(userId,itemID)
  // this function search for item by given itemID in database.
  // required string userId and itemID.
  // return Map of item that found.
  // if not return null

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

  // deleteItem(userId,itemID)
  // this function delete item by given itemID in database.
  // required string userId and itemID.
  // return status of operation.

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
