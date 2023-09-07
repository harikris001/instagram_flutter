//import 'dart:js_util';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/models/user.dart' as model;
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //sign up function
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // registeration
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photourl = await StorageMethods()
            .uploadImageToStorage('proFilePics', file, false);

        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photourl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        // add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'Email is badly formatted';
      } else if (e.code == 'weak-password') {
        res = "Weak Password";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Login Function
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please Enter all Fields';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        res = 'Check your password';
      } else if (e.code == 'user-not-found') {
        res = "Invalid Email";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
