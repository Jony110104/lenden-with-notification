import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/config/async_states.dart';
import 'package:lenden/functions/core/user_model.dart';
import 'package:lenden/functions/core/user_provider.dart';
import 'package:lenden/functions/user_handler.dart';

final updateUserProvider = NotifierProvider<UpdateUserNotifier, AsyncState>(
  UpdateUserNotifier.new,
);

class UpdateUserNotifier extends Notifier<AsyncState> {
  @override
  AsyncState build() {
    return AsyncState.initial;
  }

  // Listen to Firestore user data changes
  void updateUser(UserStoreModel user) async {
    state = AsyncState.loading;
    try {
      await UserHandler.saveUserData(user);
      ref.read(userDetailsProvider.notifier).getUser();

      state = AsyncState.success;
    } catch (e) {
      state = AsyncState.failure;
    }
    Future.delayed(const Duration(seconds: 2), () {
      state = AsyncState.initial;
    });
  }
}
