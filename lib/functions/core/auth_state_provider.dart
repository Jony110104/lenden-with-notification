import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/services/firebase.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return AppFirebaseService.auth.authStateChanges();
});
