import 'package:flutter/material.dart';
import 'package:lenden/config/colors.dart';

class MoreService extends StatelessWidget {
  const MoreService({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  'More Services',
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/receipt_2.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Tickets',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/chart_square.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Loan',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/book.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Education Fee',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/receipt_text.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Insurance Plan',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/fluent_savings.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Savings',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/mdi_donation-outline.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Donations',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/icons8_visa.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Indian Visa',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/fluent_games-24-regular.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'Games',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/more.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(height: 4,),
                        const Text(
                          'More',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
  }
}
