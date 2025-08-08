import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import '../models/user.dart';
import '../screens/auth/methods/user_storage.dart';
import 'package:flutter/foundation.dart';


class AuthMethode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future login({required String email,required String password,}) async {
    if (email.isEmpty || password.isEmpty) return 'Please fill all the fields';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      String photoUrl = '';
      if (user != null && file != null) {
          photoUrl = await _storageMethods.uploadImageToStorage(true,'profilePics', file);
      }
      if (user != null) {
        Users newUser = Users(
          uid: user.uid,
          email: user.email ?? '',
          username: username,
          bio: '',
          photoUrl: photoUrl,
          followers: [],
          following: [],
          posts: [],
          saved: [],
          searchKey: username.substring(0, 1).toUpperCase(), 
        );
        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
        return 'success';
      } else {
        return 'User creation failed';
      }
    } on FirebaseAuthException catch (e) {
        return e.message ?? 'An error occurred';
    }
  }

  Future<Users> getUserDetails() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userSnap = await _firestore.collection('users').doc(currentUser.uid).get();
      if (userSnap.exists) {
        return Users.fromSnap(userSnap);
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('User not found');
    }
  }
}
