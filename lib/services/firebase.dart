import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppFirebaseService {
  AppFirebaseService._();

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore store = FirebaseFirestore.instance;
  static bool isUserLoggedIn = auth.currentUser != null;
  static String currenuserID = auth.currentUser?.uid ??'';
  static String? currentUserEmail = auth.currentUser?.email;

  static CollectionReference<Map<String, dynamic>> userStore =
      store.collection('users');
  static CollectionReference<Map<String, dynamic>> productsStore =
      store.collection('transactions');
  static CollectionReference<Map<String, dynamic>> orderStore =
      store.collection('orders');
}
