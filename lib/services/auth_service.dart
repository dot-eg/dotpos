import '../services/navi_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui/login_screen.dart';

bool isLoggedIn = false;
String currentUser = "";
String displayname = "";
DateTime loginTime = DateTime.now();

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  Future<String> login(GlobalKey<FormState> formkey, String username, String pass, BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: pass,
      );
      final user = userCredential.user;
      if (user != null) {
        isLoggedIn = true;
        currentUser = username;
        final QuerySnapshot result = await _firestore
          .collection('User')
          .where('Email', isEqualTo: username)
          .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 1) {
          displayname = documents.first.get('DisplayName');
        }
        loginTime = DateTime.now();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CurrentPage(),
          )
      );});
        return "";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return 'Incorrect username or password. Please try again.';
    }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreenPage(),
      ),
    );
    }

  Future<String> AddUser(String displayname, String username, String pass, BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: username,
        password: pass,
      );
      final user = userCredential.user;
      if (user != null) {
        final firestore = FirebaseFirestore.instance;
        final QuerySnapshot querySnapshot = await firestore.collection('User').orderBy(FieldPath.documentId).limitToLast(1).get();
        final lastDoc = querySnapshot.docs.first;
        final int nextDocId = int.parse(lastDoc.id) + 1;
        await firestore.collection('User').doc(nextDocId.toString()).set({
          'DisplayName' : displayname,
          'Email': username,
        });
        return "User Added";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.code);
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print(e.code);
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
      return 'An error occurred. Please try again.';
    }
    return 'An error occurred. Please try again.';
  }

  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Password reset email sent";
    } catch (e) {
      print(e);
      return 'An error occurred. Please try again.';
    }
  }

  // Future<String> deleteUser(String uid) async {
  //   try {
  //     // Get the user from Firebase
  //     firebase_auth.User? firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
  
  //     // Check if the user is the one you want to delete
  //     if (firebaseUser != null && firebaseUser.uid == uid) {
  //       await firebaseUser.delete();
  //       return "User deleted";
  //     } else {
  //       return "No matching user found";
  //     }
  //   } catch (e) {
  //     print(e);
  //     return 'An error occurred. Please try again.';
  //   }

  String loginoffline(admin, context) {
    if (admin == "admin") {
      isLoggedIn = true;
      currentUser = "admin";
      loginTime = DateTime.now();
      WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CurrentPage(),
          )
          );});
      return "";
  } else {
    return "Incorrect username or password. Please try again.";
  }
}
}

class User {
  final String uid;
  final String email;
  

  User({
    required this.uid,
    required this.email,
    
  });
}

Future<List<User>> getUsersFromFirestore() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final QuerySnapshot querySnapshot = await firestore.collection('User').get();
  
  return querySnapshot.docs.map((doc) {
    return User(
      uid: doc.id,
      email: doc['Email'],

    );
  }).toList();
}