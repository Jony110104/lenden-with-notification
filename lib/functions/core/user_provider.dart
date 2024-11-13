import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/functions/core/user_model.dart';
import 'package:lenden/functions/user_handler.dart';

final userDetailsProvider =
    NotifierProvider<UserNotifier, UserStoreModel?>(UserNotifier.new);

class UserNotifier extends Notifier<UserStoreModel?> {
  @override
  UserStoreModel? build() {
    Future.microtask(() {
      getUser();
    });
    return null;
  }

  void getUser() async {
    final user = await UserHandler.getUserData();
    state = user;
  }
}
