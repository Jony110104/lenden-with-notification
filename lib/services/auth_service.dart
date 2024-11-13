import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lenden/config/router/routes.dart';
import 'package:lenden/config/toast.dart';
import 'package:lenden/services/firebase.dart';
import 'package:lenden/services/logger.dart';

class AuthService {
  AuthService._();

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await AppFirebaseService.auth.signInWithCredential(credential);
      Toast.showSuccess(context, 'Sign in successful');
      context.pushReplacement(Routes.home);
    } on Exception catch (e) {
      Log.error(e.toString());
      Toast.showError(context, 'Sign in failed');
    }
  }

  static Future<bool> signOutFromGoogle(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
