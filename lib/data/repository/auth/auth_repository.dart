import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_santa/core/utils/result.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///SIGN IN
  Future<Result<User?>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log("firebae repo: ${userCredential.user.toString()}");
      return Result.ok(userCredential.user);
    } on FirebaseAuthException catch (e) {
      log("firebase repo error: ${e.toString()}");
      return Result.error(e.message.toString());
    }
  }
  /// CREATE USER
  Future<Result<User?>> register(Map<String,String> data) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: data['email']!,
        password: data['password']!,

      );
      await userCredential.user!.updateDisplayName(data['name']);
      return Result.ok(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return Result.error(e.message.toString());
    }
  }
 ///SIGNOUT
  Future<Result> signOut() async {
    try{
      await _auth.signOut();
      return Result.ok(null);
    } on FirebaseAuthException catch(e){
      return Result.error(e.message.toString());
    }

  }

  Stream<User?> get userStream => _auth.authStateChanges();
}
