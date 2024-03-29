import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'product_home_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(GlobalKey<FormState> formkey, String username, String pass, BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: pass,
      );
      final user = userCredential.user;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProductHomePage(),
        ),
      );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
    }
    }
  }
