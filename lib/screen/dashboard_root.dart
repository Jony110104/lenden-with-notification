import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lenden/config/asstes.dart';
import 'package:lenden/config/colors.dart';
import 'package:lenden/config/router/routes.dart';
import 'package:lenden/screen/home_screen.dart';
import 'package:lenden/screen/transactionScreen.dart';
import 'package:lenden/widget/scanner_page.dart';
import 'package:lenden/widget/sidemenu.dart';

class DashboardRoot extends ConsumerStatefulWidget {
  const DashboardRoot({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardRootState();
}

class _DashboardRootState extends ConsumerState<DashboardRoot> {
  int _bottomNavIndex = 0;
  final iconList = [
    [AppAssets.svg.homeFill, AppAssets.svg.homeLine, 'Home'],
    [AppAssets.svg.activityFill, AppAssets.svg.activityLine, 'Transactions']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: MyColor.pageBg,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),

        onPressed: () {
          context.push(Routes.scanner);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset(
            'assets/icons/scan.png',
            height: 120,
            width: 120,
          ),
        ),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final tabData = iconList[index];
          final svg = isActive ? tabData[0] : tabData[1];
          final title = tabData[2];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svg,
                width: 24,
                height: 24,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.black : Colors.black54),
              )
            ],
          );
        },

        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: const [
          HomeScreen(),
          TransactionScreen(),
        ],
      ),
    );
  }
}
