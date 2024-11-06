import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_ticket_booking/pages/home_screen.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class ProfileController extends ChangeNotifier {
  final userDocRef = firestore.collection(userCollection).doc;
  UserModel _currentUser = UserModel(name: 'name', email: 'email', phone: 'phone', nic: 'nic');
  UserModel get currentUser => _currentUser;

  /// get user Stream changes snapshots
  // Future getUserInfo() async {
  //   /// This will return the document snapshot
  //   DocumentSnapshot docSnap = await userDoc(auth.currentUser!.uid).get();
  //
  //   /// then we will extract this snapshot data
  //   Object? data = docSnap.data();
  //
  //   // now returning this data object which is actually the Map
  //   return data;
  // }

  getCurrentUserInfo() async {
    final userData = await userDocRef(auth.currentUser!.uid).get();
    Map<String, dynamic>? data = userData.data();
    _currentUser = UserModel.fromJson(data!);
    notifyListeners();
  }

  /// get user Stream changes snapshots
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser() {
    return userDocRef(auth.currentUser!.uid).snapshots();
  }

  /// create user
  Future createUser({required UserModel theUser}) async {
    try {
      UserModel newUser = theUser;
      await userDocRef(auth.currentUser!.uid).set(
        {
          'name': newUser.name,
          'phone': newUser.phone,
          'email': newUser.email,
          'nic': newUser.nic,
          'password': newUser.password,
        },
      );
    } on FirebaseException catch (e) {
      print('________________________________________ ======================================');
      print(e.message!);
      // Utils.showErrorSnackBar(e.message!);
    }
    notifyListeners();
  }

  /// signUp
  Future signUp({required UserModel newUser, context}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: newUser.email.trim(), password: newUser.password!).then((value) {
        createUser(theUser: newUser).then((value) {});
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        return null;
      });
    } on FirebaseAuthException catch (e) {
      auth.signOut();
      Utils.showErrorSnackBar(e.message!);
    }
  }

  /// Sign In
  Future signIn({required String email, required String password, context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim()).then((value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
        return null;
      });
    } on FirebaseAuthException catch (e) {
      auth.signOut();
      Utils.showErrorSnackBar(e.message!);
    }
  }

  /// Update user
  Future<void> updateUser({required UserModel updatedUser}) async {
    try {
      await userDocRef(auth.currentUser!.uid).update({
        'name': updatedUser.name,
        'phone': updatedUser.phone,
        'nic': updatedUser.nic,
        'password': updatedUser.password,
      });
    } on FirebaseException catch (e) {
      print(e.message!);
      // Utils.showErrorSnackBar(e.message!);
    }
    notifyListeners();
  }

// Future updateUser({String? name, required String image}) async {
  //   try {
  //     await userDocRef(auth.currentUser!.uid).update({
  //       'name': name,
  //       'image': image,
  //     });
  //   } on FirebaseException catch (e) {
  //     Utils.showErrorSnackBar(e.message!);
  //   }
  //   notifyListeners();
  // }
}
