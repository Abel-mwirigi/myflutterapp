import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/del-update.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_application_1/views/customtext.dart';
import 'package:flutter_application_1/controllers/UserController.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final userController = Get.find<UserController>();
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/user/user/${userController.getUser()?.id?? "User"}/transactions/'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        transactions =
            responseData.map((data) => Transaction.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 320, child: _head()),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: 'Transactions history',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      labelColor: Colors.black,
                    ),
                    CustomText(
                      label: 'See all',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      labelColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showTransactionDialog(context, transactions[index]);
                    },
                    child: ListTile(
                      title: Text(
                        transactions[index].name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        transactions[index].time,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Text(
                        transactions[index].fee,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color: transactions[index].buy
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ),
                  );
                },
                childCount: transactions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _head() {
  final userController = Get.find<UserController>();
  double totalIncome = 0;
  double totalExpenses = 0;

  for (final transaction in transactions) {
    if (transaction.buy) {
      // Subtract additional expenses from the total income and add them to expenses
      totalIncome -= double.parse(transaction.fee);
      totalExpenses += double.parse(transaction.fee);
    } else {
      totalIncome += double.parse(transaction.fee);
    }
  }

  return Stack(
    children: [
      Column(
        children: [
          Container(
            width: double.infinity,
            height: 240,
            decoration: const BoxDecoration(
              color: Color(0xff368983),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  left: 305,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: const Color.fromRGBO(250, 250, 250, 0.1),
                      child: const Icon(
                        Icons.notification_add_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          label: 'Hello!,',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          labelColor: Color.fromARGB(255, 224, 223, 223)),
                      CustomText(
                          label: "${userController.getUser()?.username ?? "User"}",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          labelColor: Color.fromARGB(255, 224, 223, 223)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: 140,
        left: 25,
        child: Container(
          height: 170,
          width: 310,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(47, 125, 121, 0.3),
                offset: Offset(0, 6),
                blurRadius: 12,
                spreadRadius: 6,
              ),
            ],
            color: Color.fromARGB(255, 53, 139, 139),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: 'Mpesa Balance',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      labelColor: Colors.white,
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    CustomText(
                      label: '\$ $totalIncome',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      labelColor: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(255, 85, 145, 141),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                        SizedBox(width: 7),
                        CustomText(
                          label: 'Income',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          labelColor: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(255, 85, 145, 141),
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                        SizedBox(width: 7),
                        CustomText(
                          label: 'Expenses',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          labelColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: '\$ $totalIncome',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      labelColor: Colors.white,
                    ),
                    CustomText(
                      label: '\$ $totalExpenses',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      labelColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
}

void _showTransactionDialog(BuildContext context, Transaction transaction) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Transaction Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                final bool success =
                    await TransactionService.deleteTransaction(transaction.id);
                if (success) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Transaction deleted successfully'),
                    ),
                  );
                  }
                  else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete transaction'),
                    ),
                  );
                }
              },
              child: Text('Delete'),
            ),
          ],
        ),
      );
    },
  );
}

class Transaction {
  final int id;
  final String name;
  final String time;
  final String fee;
  final bool buy;

  Transaction({
    required this.id,
    required this.name,
    required this.time,
    required this.fee,
    required this.buy,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      name: json['name'] as String,
      time: json['time'] as String,
      fee: json['fee'] as String,
      buy: json['buy'] as bool,
    );
  }
}
