import 'package:flutter/material.dart';
import 'package:lenden/screen/addMoneyScreen.dart';
import 'package:lenden/screen/cashoutScreen.dart';
import 'package:lenden/screen/sendMoneyScreen.dart';
import 'package:lenden/widget/bank_page.dart';
import 'package:lenden/widget/bkash_page.dart';

class Service extends StatelessWidget {
  const Service({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendMoneyScreen(),
                      ));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/money_send.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Send Money',
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
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => BkashPage(title: 'bkash'),));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/card_receive.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Mobile Recharge',
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CashoutScreen()));
                },

                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/wallet_minus.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Cash Out',
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
                        'assets/icons/card_send.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Make Payment',
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BkashPage(title: 'bkash'),));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/wallet_money.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Pay Bill',
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddMoneyScreen()));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/card_add.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Add Money',
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BankTranfer(),));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3 - 13.33,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/bank.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Bank Transfer',
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
                        'assets/icons/cards.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Request Money',
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
                        'assets/icons/shopping_cart.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(height: 4,),
                      const Text(
                        'Shopping',
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
