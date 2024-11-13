import 'package:flutter/material.dart';

class Sliders extends StatefulWidget {
  const Sliders({super.key});

  @override
  State<Sliders> createState() => _SlidersState();
}



class _SlidersState extends State<Sliders> {
  final List colors = [{},{},{},{},{}];
  int currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 102,
            child: PageView.builder(
              itemCount: colors.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  'assets/images/slider_1.png',
                  fit: BoxFit.cover,
                );
              },
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < colors.length; i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: i == _currentPage ? 10.0 : 8.0,
                width: i == _currentPage ? 10.0 : 8.0,
                decoration: BoxDecoration(
                  color: i == _currentPage ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(50),
                ),
              )

          ],
        ),
      ],
    );
  }
}
