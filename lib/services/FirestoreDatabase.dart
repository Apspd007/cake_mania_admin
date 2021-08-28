import 'package:cake_mania/services/AuthenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  Stream<DocumentSnapshot<Object?>> getUserDataAsStream(String userId);
  Future<DocumentSnapshot<Object?>> getUserDataAsFuture(String userId);
  // Future<DocumentSnapshot<Object?>> getCakeIdAsFuture(String cakeId);
  Future<void> addUser(String userId, Map<String, dynamic> data);
  Future<void> updateUser(String userId, String key, dynamic value);
  Future<void> deleteUser(String userId);
  Future<void> addToFavourite(String userId, int value);
  Future<void> removeFromFavourite(String userId, int value);
  Future<void> confirmOrder(LocalUser user, Map<String, dynamic> value);
  Future<DocumentSnapshot<Object?>> allCakes();
}

class MyFirestoreDatabse implements Database {
  CollectionReference _adminReference =
      FirebaseFirestore.instance.collection('admin');
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');
  CollectionReference _cakeColReference =
      FirebaseFirestore.instance.collection('cakes');
  // CollectionReference _cakeIdReference =
  //     FirebaseFirestore.instance.collection('cakeId');

  Stream<DocumentSnapshot<Object?>> getUserDataAsStream(String userId) {
    // final _doc = _userReference.doc("fTVZ94nHyJzYIy8kRvkO").snapshots();
    final _doc = _userReference.doc(userId).snapshots();
    return _doc;
  }

  Future<DocumentSnapshot<Object?>> getUserDataAsFuture(String userId) {
    // final _doc = _userReference.doc("fTVZ94nHyJzYIy8kRvkO").snapshots();
    final _doc = _userReference.doc(userId).get();
    return _doc;
  }
  // Future<DocumentSnapshot<Object?>> getCakeIdAsFuture(String cakeId) {
  //   final _doc = _userReference.doc(cakeId).get();
  //   return _doc;
  // }

  Future<DocumentSnapshot<Object?>> allCakes() async {
    final _doc = _cakeColReference.doc("cakeList").get();
    return _doc;
  }

  Future<void> confirmOrder(LocalUser user, Map<String, dynamic> json) async {
    _adminReference
        .doc("cakeOrders")
        .collection("users")
        .doc(user.displayName)
        .set({
          'confirmOrders': [json]
        })
        .then((json) => print("Order Confirmed from Admin"))
        .catchError(
            (error) => print("Failed to Confirm Order from Admin: $error"));
    _userReference
        .doc(user.uid)
        .update({
          'UserData.confirmOrders': FieldValue.arrayUnion([json])
        })
        .then((json) => print("Order Confirmed from User"))
        .catchError(
            (error) => print("Failed to Confirm Order from User: $error"));
  }

  Future<void> addToFavourite(String userId, int value) async {
    _userReference
        .doc(userId)
        .update({
          'UserData.favourites': FieldValue.arrayUnion([value])
        })
        .then((value) => print("Favourite list Updated"))
        .catchError(
            (error) => print("Failed to update favourite list: $error"));
  }

  Future<void> removeFromFavourite(String userId, int value) async {
    _userReference
        .doc(userId)
        .update({
          'UserData.favourites': FieldValue.arrayRemove([value])
        })
        .then((value) => print("Favourite list Updated"))
        .catchError(
            (error) => print("Failed to update favourite list: $error"));
  }

  Future<void> addUser(String userId, Map<String, dynamic> data) async {
    _adminReference
        .doc("cakeOrders")
        .collection("users")
        .doc(userId)
        .set({"confirmOrders": []})
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
    _userReference
        .doc(userId)
        .set(data)
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(String userId, String key, dynamic value) async {
    /// key must be accurate ex. {UserData.searchedKeywords:'keyword'}
    /// key = UserData.searchedKeywords, value = 'keyword'
    _userReference
        .doc(userId)
        .update({key: value})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser(String userId) async {
    _userReference
        .doc(userId)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
