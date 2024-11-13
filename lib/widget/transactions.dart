import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenden/config/StorageService.dart';
import 'package:lenden/config/colors.dart';
import 'package:lenden/functions/core/user_provider.dart';
import 'package:lenden/screen/transactionScreen.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Transactions extends ConsumerStatefulWidget {
  final String title;
  const Transactions({super.key, this.title = 'Recent Transactions'});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionsState();
}

class _TransactionsState extends ConsumerState<Transactions> {
  // final List<dynamic> dataList = [
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : 'Today at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 1
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '220',
  //     'date'    : 'Yesterday at 9:00 AM',
  //     'message' : 'Received Money',
  //     'type'    : 0
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 2
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Add Money',
  //     'type'    : 0
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Send Money',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 2
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '220',
  //     'date'    : 'Yesterday at 9:00 AM',
  //     'message' : 'Received Money',
  //     'type'    : 0
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 2
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Add Money',
  //     'type'    : 0
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Send Money',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 2
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '220',
  //     'date'    : 'Yesterday at 9:00 AM',
  //     'message' : 'Received Money',
  //     'type'    : 0
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 2
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Add Money',
  //     'type'    : 0
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Send Money',
  //     'type'    : 3
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '80',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 2
  //   },
  //   {
  //     'number'  : '01305290983',
  //     'amount'  : '50',
  //     'date'    : '01 May 2024 at 9:00 AM',
  //     'message' : 'Make Payment',
  //     'type'    : 3
  //   }
  // ];

  final StorageService _storageService = StorageService();
  List<dynamic> transactions = [];
  List<List<dynamic>> transaction = [];

  @override
  void initState() {
    super.initState();
    _getTransactions();
  }

  void _getTransactions() async {
    String? data = await _storageService.getData('transactions');
    // print(data);
    if (data != null) {
      setState(() {
        List<dynamic> jsonList = jsonDecode(data);
        transactions = jsonList;
      });
    }
  }

  Future<void> downloadPdf(BuildContext context, String name) async {
    final pdf = pw.Document();

    List data = transactions;

    // Create table data
    List<List<String>> tableData = [
      ['Date', 'Type', 'To/From', 'Amount']
    ];

    for (var item in data) {
      tableData.add([
        item['date'].toString(),
        item['message'].toString(),
        item['number'].toString(),
        '${item['amount']} tk'.toString(),
      ]);
    }
    // Add a page with a table to the PDF

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                    pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Lenden',
                                style: pw.TextStyle(
                                    fontSize: 30,
                                    font: pw.Font.helveticaBold(),
                                    color: PdfColors.green900)),
                            pw.Text(
                              'Banking with blockchain',
                            ),
                          ]),
                    ),
                    pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text('Statement of Account',
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  font: pw.Font.helveticaBold(),
                                )),
                            pw.Text('Dhaka Branch',
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  font: pw.Font.helveticaBold(),
                                )),
                            pw.Text(
                              'N Tower 2nd Floor, Mirpur 10',
                            ),
                            pw.Text(
                              'Dhaka - 1200',
                            ),
                          ]),
                    ),
                  ])),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 20),
                height: 2,
                width: double.infinity,
                color: PdfColors.grey200,
              ),
              pw.Container(
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                    pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(name,
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  font: pw.Font.helveticaBold(),
                                )),
                            pw.Text(
                              'Savings Account',
                            ),
                            pw.Text(
                              'Halishahar Chattogram - 4125',
                            ),
                          ]),
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Period From',
                                  ),
                                  pw.Text(
                                    'Period To',
                                  ),
                                  pw.Text(
                                    'Account Number',
                                  ),
                                  pw.Text(
                                    'Customer ID',
                                  ),
                                  pw.Text(
                                    'Currency',
                                  ),
                                ]),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Container(
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    ': 12-01-2024',
                                  ),
                                  pw.Text(
                                    ': 12-02-2024',
                                  ),
                                  pw.Text(
                                    ': 63565423655',
                                  ),
                                  pw.Text(
                                    ': 65419216562',
                                  ),
                                  pw.Text(
                                    ': BDT',
                                  ),
                                ]),
                          ),
                        ])
                  ])),
              pw.SizedBox(height: 20),
              // pw.Container(
              //   margin: const pw.EdgeInsets.symmetric(vertical: 20),
              //   height: 2,
              //   width: double.infinity,
              //   color: PdfColors.grey200,
              // ),
              // pw.Container(
              //     padding: const pw.EdgeInsets.only(bottom: 20),
              //     child: pw.Text('Transaction History',
              //         style: pw.TextStyle(
              //           fontSize: 18,
              //           font: pw.Font.helveticaBold(),
              //         ))),
              pw.Table.fromTextArray(data: tableData),

              // pw.Table(
              //   defaultColumnWidth: pw.FixedColumnWidth(120.0),
              //   border: pw.TableBorder.all(
              //       color: PdfColors.black,
              //       style: pw.BorderStyle.solid,
              //       width: 1),
              //   children: [
              //     pw.TableRow(children: [
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             color: PdfColors.grey700,
              //             child: pw.Text('Date',
              //                 style: pw.TextStyle(
              //                     color: PdfColors.white,
              //                     fontSize: 14.0,
              //                     font: pw.Font.helveticaBold())))
              //       ]),
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             color: PdfColors.grey700,
              //             child: pw.Text('Type',
              //                 style: pw.TextStyle(
              //                     color: PdfColors.white,
              //                     fontSize: 14.0,
              //                     font: pw.Font.helveticaBold())))
              //       ]),
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             color: PdfColors.grey700,
              //             child: pw.Text('To',
              //                 style: pw.TextStyle(
              //                     color: PdfColors.white,
              //                     fontSize: 14.0,
              //                     font: pw.Font.helveticaBold())))
              //       ]),
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             color: PdfColors.grey700,
              //             child: pw.Text('Amount',
              //                 style: pw.TextStyle(
              //                     color: PdfColors.white,
              //                     fontSize: 14.0,
              //                     font: pw.Font.helveticaBold())))
              //       ]),
              //     ]),
              //     pw.TableRow(children: [
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             child: pw.Text('21 Jun, 2024',
              //                 style: pw.TextStyle(
              //                   fontSize: 12.0,
              //                 )))
              //       ]),
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             child: pw.Text('Send Money',
              //                 style: pw.TextStyle(
              //                   fontSize: 12.0,
              //                 )))
              //       ]),
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             child: pw.Text('01305290983',
              //                 style: pw.TextStyle(
              //                   fontSize: 12.0,
              //                 )))
              //       ]),
              //       pw.Column(children: [
              //         pw.Container(
              //             padding: pw.EdgeInsets.symmetric(
              //                 horizontal: 8, vertical: 4),
              //             width: double.infinity,
              //             child: pw.Text('1200',
              //                 style: pw.TextStyle(
              //                   fontSize: 12.0,
              //                 )))
              //       ]),
              //     ]),
              //   ],
              // ),
            ],
          ));
        },
      ),
    );

    // Fetch data from API
    //
    //   pdf.addPage(
    //     pw.Page(
    //       build: (context) {
    //         return pw.Table.fromTextArray(data: tableData);
    //       },
    //     ),
    //   );

    // print(data);

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/transactions.pdf");
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDetailsProvider);
    return Column(
      children: [
        Visibility(
          visible: widget.title == 'Recent Transactions' ? false : true,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Download Invoice',
                  style: TextStyle(
                      color: MyColor.textNormal,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    downloadPdf(context, user?.name ?? 'Joni Nath');
                  },
                  child: SvgPicture.asset('assets/icons/download_fill.svg'),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: MyColor.textNormal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Visibility(
                    visible:
                        widget.title == 'Recent Transactions' ? true : false,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.title == 'Recent Transactions') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TransactionScreen(),
                              ));
                        }
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            color: MyColor.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(color: Colors.black12),
              ),
              const SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: _buildChildren(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.title == 'Recent Transactions' ? 0 : 120,
        )
      ],
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    List<Widget> children = [];
    for (int index = 0; index < transactions.length; index++) {
      children.add(
        Container(
          margin: EdgeInsets.only(
              bottom: index == transactions.length - 1 ? 0 : 16),
          width: MediaQuery.of(context).size.width * 1.0 - 82,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: transactions[index]['type'] == 0
                          ? Colors.green.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SvgPicture.asset(
                        height: 24,
                        width: 24,
                        transactions[index]['type'] == 0
                            ? 'assets/icons/card_receive.svg'
                            : 'assets/icons/card_send.svg'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index]['message'].toString(),
                        style: TextStyle(
                            color: transactions[index]['type'] == 0
                                ? MyColor.textSuccess
                                : MyColor.textDanger,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        transactions[index]['number'],
                        style: TextStyle(
                          color: MyColor.textNormal,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactions[index]['type'] == 0
                        ? '+${transactions[index]['amount']}৳'
                        : '-${transactions[index]['amount']}৳',
                    style: TextStyle(
                        color: transactions[index]['type'] == 0
                            ? MyColor.textSuccess
                            : MyColor.textDanger,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    transactions[index]['date'],
                    style: TextStyle(color: MyColor.textNormal, fontSize: 9),
                  )
                ],
              ),
              Container(
                height: 20,
                width: 20,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(50)),
                child: SvgPicture.asset('assets/icons/arrow_right.svg'),
              )
            ],
          ),
        ),
      );
    }
    return children;
  }
}
