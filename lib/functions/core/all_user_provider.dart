import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/functions/core/auth_state_provider.dart';
import 'package:lenden/functions/core/user_model.dart';
import 'package:lenden/services/firebase.dart';


final allUserProviderProvider = NotifierProvider<AllUserNotifier, AllUserState>(
  AllUserNotifier.new,
);

class AllUserNotifier extends Notifier<AllUserState> {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _docsStream;

  @override
  AllUserState build() {
    Future.microtask(() {
      ref.watch(authStateProvider).whenOrNull(
        data: (user) {
          if (user != null) {
            _listenToUserData();
          } else {
            _cancelUserDataStream();
            state = AllUserState();
          }
        },
      );
    });
    _dispose();
    return AllUserState();
  }

  void _listenToUserData() {
    final docRef = AppFirebaseService.userStore;
    _docsStream = docRef.snapshots().listen(
      (event) async {
        if (event.docs.isNotEmpty) {
          final codes = event.docs
              .map((e) => UserStoreModel.fromMap({...e.data(), 'id': e.id}))
              .toList();
          state = state.copyWith(users: codes);
        }
      },
    );
  }

  // Cancel the Firestore stream when the user logs out
  Future<void> _cancelUserDataStream() async {
    await _docsStream?.cancel();
    _dispose();
    _docsStream = null;
  }

  void _dispose() {
    ref.onDispose(() {
      _docsStream?.cancel();
    });
  }
}

class AllUserState {
  AllUserState({
    this.users = const [],
    this.error,
  });
  final List<UserStoreModel> users;
  final String? error;
  AllUserState copyWith({
    List<UserStoreModel>? users,
    String? error,
  }) {
    return AllUserState(
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }
}
