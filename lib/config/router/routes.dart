import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lenden/authentication/auth.dart';
import 'package:lenden/authentication/onboard_Screen.dart';
import 'package:lenden/authentication/splash_screen.dart';
import 'package:lenden/screen/dashboard_root.dart';
import 'package:lenden/screen/edit_user.dart';
import 'package:lenden/screen/notifications_screen.dart';
import 'package:lenden/screen/set_reminder.dart';
import 'package:lenden/services/logger.dart';
import 'package:lenden/widget/scanner_page.dart';

class _RoutesNames {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const editAccount = '/edit-account';
  static const scanner = '/scanner';
  static const setReminder = '/set-reminder';
  static const notifications = '/notifications';
  static const login = '/login';
}

class Routes {
  static String get splash => _RoutesNames.splash;
  static String get onboarding => _RoutesNames.onboarding;
  static String get home => _RoutesNames.home;
  static String get editAccount => home + _RoutesNames.editAccount;
  static String get scanner => home + _RoutesNames.scanner;
  static String get reminder => home + _RoutesNames.setReminder;
  static String get notifications => home + _RoutesNames.notifications;
  static String get login => _RoutesNames.login;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
          path: _RoutesNames.splash,
          builder: (context, state) => const SplashScreen(),
          routes: [
            GoRoute(
              path: _RoutesNames.onboarding,
              builder: (context, state) => const Onboard_Screen(),
              // redirect: (context, state) {
              //   final loggedIN = FirebaseAuth.instance.currentUser !=null;
              //   if (loggedIN) {
              //     return _RoutesNames.home;
              //   }
              //   return null;
              // },
            ),
          ]),
      GoRoute(
        path: _RoutesNames.home,
        builder: (context, state) => const DashboardRoot(),
        // redirect: (context, state) {
        //   final loggedIN = FirebaseAuth.instance.currentUser !=null;
        //   Log.info('Logged In: $loggedIN');
        //   if (!loggedIN) {
        //     return _RoutesNames.login;
        //   }
        //   return null;
        // },
        routes: [
          GoRoute(
            path: _RoutesNames.scanner,
            builder: (context, state) => const ScannerPage(),
          ),
          GoRoute(
            path: _RoutesNames.editAccount,
            builder: (context, state) => const EditUserData(),
          ),
          GoRoute(
            path: _RoutesNames.setReminder,
            builder: (context, state) => const SetReminderScreen(),
          ),
          GoRoute(
            path: _RoutesNames.notifications,
            builder: (context, state) => const NotificationsScreen(),
          ),
          // GoRoute(
          //   path: _RoutesNames.admin,
          //   builder: (context, state) => const AdminScreen(),
          //   routes: const [],
          //   redirect: (context, state) {
          //     final user = ref.read(userProvider).user;
          //     if (user != null && (user.role == 888 || user.role == 999)) {
          //       return null;
          //     }
          //     return _RoutesNames.home;
          //   },
          // ),
        ],
      ),
      GoRoute(
        path: _RoutesNames.login,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
    redirect: (context, state) {
      Log.info('Redirection Check Full Path ${state.fullPath}');
      // TODO(eltanvir): Implement auth token provider
      // final token = ref.read(authTokenProvider);
      // if (token == null || token.isEmpty) {
      //   return '/login';
      // }
      return null;
    },
  );
  // ref.listen<AsyncValue<User?>>(authStateProvider, (previous, next) {
  //   next.whenData((user) {
  //     if (user != null) {
  //       router.go(Routes.home);
  //     } else {
  //       router.go(Routes.splash);
  //     }
  //   });
  // });
  return router;
});
