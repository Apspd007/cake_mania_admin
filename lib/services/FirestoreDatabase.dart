import 'package:cake_mania_admin/Models/CakeModel.dart';
import 'package:cake_mania_admin/services/AuthenticationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class Database {
  Stream<DocumentSnapshot<Object?>> getUserDataAsStream(String userId);
  Future<DocumentSnapshot<Object?>> getUserDataAsFuture(String userId);
  Future<void> createSection(String sectionName, String sectionColor);
  Stream<QuerySnapshot<Object?>> getSections();
  Future<void> deleteSection(String sectionName);
  // Future<DocumentSnapshot<Object?>> getCakeIdAsFuture(String cakeId);
  Future<void> addUser(String userId, Map<String, dynamic> data);
  Future<void> updateUser(String userId, String key, dynamic value);
  Future<void> deleteUser(String userId);
  Future<void> addToFavourite(String userId, int value);
  Future<void> removeFromFavourite(String userId, int value);
  Future<void> confirmOrder(LocalUser user, Map<String, dynamic> value);
  void addCakeToSection(String sectionName, CakeModel cakeModel);
  Stream<DocumentSnapshot<Object?>> getAllCakes();
}

class MyFirestoreDatabse implements Database {
  CollectionReference _adminReference =
      FirebaseFirestore.instance.collection('admin');
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');
  CollectionReference _cakeColReference =
      FirebaseFirestore.instance.collection('cakes');
  CollectionReference _cakeIdsReference =
      FirebaseFirestore.instance.collection('cakeIds');
  CollectionReference _cakeSectionReference =
      FirebaseFirestore.instance.collection('cakeSections');
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

  Stream<DocumentSnapshot<Object?>> getAllCakes() {
    final _doc = _cakeColReference.doc("cakeList").snapshots();
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

  void addCakeToSection(String sectionName, CakeModel cakeModel) {
    _cakeSectionReference
        .doc(sectionName)
        .update({
          "cakeModels": FieldValue.arrayUnion([CakeModel.toJson(cakeModel)]),
        })
        .then((value) =>
            print("Cake Added to the Section: $sectionName Successfully"))
        .catchError((error) =>
            print("Failed to Add Cake to Section: $sectionName $error"));
    _cakeColReference
        .doc("cakeList")
        .update({
          "cakeList": FieldValue.arrayUnion([CakeModel.toJson(cakeModel)]),
        })
        .then((value) => print("Cake Added to the CakeList Successfully"))
        .catchError((error) => print("Failed to Add Cake to CakeList $error"));
    _cakeIdsReference
        .doc(cakeModel.cakeId.toString())
        .set(
          CakeModel.toJson(cakeModel),
        )
        .then((value) => print("Cake Added to the cakeIds List Successfully"))
        .catchError(
            (error) => print("Failed to Add Cake to cakeIds List $error"));
  }

  Stream<QuerySnapshot<Object?>> getSections() {
    final section = _cakeSectionReference.snapshots();
    return section;
  }

  Future<void> deleteSection(String sectionName) async {
    _cakeSectionReference.doc(sectionName).delete();
  }

  Future<void> createSection(String sectionName, String sectionColor) async {
    _cakeSectionReference
        .doc(sectionName)
        .set({
          'title': sectionName,
          'cardColor': sectionColor,
          'cakeModels': [],
        })
        .then((value) => print("Section Created Successfully"))
        .catchError((error) => print("Failed to Create a Section: $error"));
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
