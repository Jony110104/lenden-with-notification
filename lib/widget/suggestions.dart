import 'package:flutter/material.dart';
import 'package:lenden/config/colors.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suggestions',
                  style: TextStyle(
                      color: MyColor.textNormal,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      color: MyColor.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                  color: Colors.black12
              ),
            ),
            const SizedBox(height: 16,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/10minschool.png',
                          height: 20,
                        ),
                        const SizedBox(height: 16,),
                        Text(
                          '10 Minute School',
                          style: TextStyle(
                            color: MyColor.textNormal,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/quizgiri.png',
                          height: 25,
                        ),
                        const SizedBox(height: 16,),
                        Text(
                          'Quizgiri',
                          style: TextStyle(
                            color: MyColor.textNormal,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/daraz.png',
                          height: 30,
                        ),
                        const SizedBox(height: 16,),
                        Text(
                          'Daraz',
                          style: TextStyle(
                            color: MyColor.textNormal,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}
