import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lenden/config/StorageService.dart';
import 'package:lenden/config/colors.dart';
import 'package:lenden/screen/home_screen.dart';
import 'package:lenden/widget/sidemenu.dart';
import 'package:intl/intl.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final StorageService _storageService = StorageService();
  String _balance = '-';

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  List<dynamic> transactions = [];

  bool menuOpen = false;

  void hideMenu() {
    setState(() {
      menuOpen = false;
    });
  }

  void sendMoney() {
    if (_numberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid number!')),
      );
    } else if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid amount!')),
      );
    } else if (double.parse(_balance) > double.parse(_amountController.text)) {
      final DateFormat formatter = DateFormat('d MMM, y');
      var arr = {
        'number': _numberController.text.toString(),
        'amount': _amountController.text.toString(),
        'date': formatter.format(DateTime.now()).toString(),
        'message': 'Send Money',
        'type': 1,
      };
      transactions.add(arr);
      _saveTransaction();
      _adjustBalance(
          (double.parse(_balance) - double.parse(_amountController.text))
              .toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Send money successful!')),
      );
      _numberController.text = '';
      _amountController.text = '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient balance!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getBalance();
    _getTransactions();
  }

  void _saveTransaction() async {
    await _storageService.saveData('transactions', jsonEncode(transactions));
  }

  void _getTransactions() async {
    String? data = await _storageService.getData('transactions');
    if (data != null) {
      setState(() {
        List<dynamic> jsonList = jsonDecode(data);
        transactions = jsonList;
      });
    }
  }

  void _getBalance() async {
    String? data = await _storageService.getData('balance');
    setState(() {
      _balance = data ?? '-';
    });
  }

  void _adjustBalance(String amount) async {
    await _storageService.saveData('balance', amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: MyColor.darkColor,
        backgroundColor: MyColor.darkColor,
      ),
      backgroundColor: MyColor.pageBg,
      body: Stack(
        children: [
          Column(
            children: [
              // TODO: Header
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                color: MyColor.darkColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child:
                                SvgPicture.asset('assets/icons/arrow_left.svg'),
                          ),
                          const Text(
                            'Send Money',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
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
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              //TODO: Body
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TODO: Transactions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              controller: _numberController,
                              decoration: InputDecoration(
                                  hintText: 'Enter number',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: const EdgeInsets.all(17),
                                  border: InputBorder.none,
                                  prefixIcon: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      'assets/icons/call.svg',
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TODO: Transactions
                      Container(
                        width: 250,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                          ],
                          controller: _amountController,
                          decoration: InputDecoration(
                              hintText: 'Enter amount',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: const EdgeInsets.all(17),
                              border: InputBorder.none,
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  'assets/icons/coin.svg',
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TODO: Transactions
                      GestureDetector(
                        onTap: () {
                          sendMoney();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 44,
                          decoration: BoxDecoration(
                            color: MyColor.darkColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            'Send Money',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: menuOpen,
            child: SideMenu(
              voidCallback: hideMenu,
            ),
          )
        ],
      ),
    );
  }
}
