import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lenden/config/StorageService.dart';
import 'package:lenden/config/balance_hide.dart';
import 'package:lenden/config/router/routes.dart';
import 'package:lenden/functions/core/user_provider.dart';
import 'package:lenden/widget/more_service.dart';
import 'package:lenden/widget/offers.dart';
import 'package:lenden/widget/service.dart';
import 'package:lenden/widget/sidemenu.dart';
import 'package:lenden/widget/slider.dart';
import 'package:lenden/widget/suggestions.dart';
import 'package:lenden/widget/transactions.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final StorageService _storageService = StorageService();
  String _balance = '0';
  bool hide = true;

  bool menuOpen = false;
  void hideMenu() {
    setState(() {
      menuOpen = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  void _getBalance() async {
    String? data = await _storageService.getData('balance');

    setState(() {
      _balance = data ?? '0';
      if (double.parse(_balance) < 10) {
        _adjustBalance('5000');
      }
    });
  }

  void _adjustBalance(String amount) async {
    await _storageService.saveData('balance', amount);
    _getBalance();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final user = ref.watch(userDetailsProvider);

    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 100),
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/header_bg.png'),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/profile.png',
                            height: 48,
                            width: 48,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            user?.name ?? 'Guest',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.push(Routes.notifications);
                            },
                            child: Image.asset(
                              'assets/icons/notification_icon.png',
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                menuOpen = true;
                              });
                            },
                            child: Image.asset(
                              'assets/icons/menu_icon.png',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              '৳ ${HideBalance.balance(_balance, hide)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              hide = !hide;
                            }),
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset(
                                'assets/icons/eye_slash.png',
                                height: 48,
                                width: 48,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // TODO: Service Card
                  const Service(),
                  const SizedBox(
                    height: 16,
                  ),
                  // TODO: Slider
                  const Sliders(),
                  const SizedBox(
                    height: 16,
                  ),
                  // TODO: Suggestions
                  const Suggestions(),
                  const SizedBox(
                    height: 16,
                  ),
                  // TODO: Offers
                  const Offers(),
                  const SizedBox(
                    height: 16,
                  ),
                  // TODO: More Services
                  const MoreService(),
                  const SizedBox(
                    height: 16,
                  ),
                  // TODO: Transactions
                  const Transactions(),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: menuOpen,
          child: SideMenu(
            voidCallback: hideMenu,
          ),
        )
      ],
    );
  }
}
