import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lenden/config/colors.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    required this.tabs,
    required this.tabsWidgets,
    super.key,
  }) : assert(
          tabs.length == tabsWidgets.length,
          'Lengths of tabs and tabsWidgets do not match.',
        );
  final List<String> tabs;
  final List<Widget> tabsWidgets;

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColor.darkColor,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              width: constraints.maxWidth,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: (_currentIndex * width / widget.tabs.length) -
                        ((_currentIndex == widget.tabs.length - 1) ? 5 : 0),
                    child: Container(
                      height: 30,
                      width: (width / 2) - 10,
                      decoration: BoxDecoration(
                        color: MyColor.darkColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        ...widget.tabs.asMap().entries.map((e) {
                          return _TabItemBuilder(
                            onTap: () => setState(
                              () => _currentIndex = e.key,
                            ),
                            title: e.value,
                            selected: _currentIndex == e.key,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: widget.tabsWidgets,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TabItemBuilder extends ConsumerWidget {
  const _TabItemBuilder({
    required this.title,
    required this.selected,
    required this.onTap,
  });
  final String title;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 30,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
