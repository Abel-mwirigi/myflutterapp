import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/views/chart.dart';
import 'package:flutter_application_1/views/customtext.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/UserController.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<Transaction> transactions = [];
  Map<String, double> dataMap = {};

   @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final userController = Get.find<UserController>();
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/user/user/${userController.getUser()?.id ?? "User"}/transactions/'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final Map<String, double> updatedDataMap = processData(responseData);
      setState(() {
        transactions = responseData.map((data) => Transaction.fromJson(data)).toList();
        dataMap = updatedDataMap;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map<String, double> processData(List<dynamic> responseData) {
    // Process fetched data into the format expected by the pie chart
    final Map<String, double> processedData = {};
    responseData.forEach((data) {
      final String name = data['name'] as String;
      final double fee = double.parse(data['fee'] as String);
      processedData[name] = fee;
    });
    return processedData;
  }
  List day = ['Day', 'Week', 'Month', 'Year'];
  int index_color = 0;
  @override
  Widget build(BuildContext context) {
     // Sort transactions based on fee (convert to double first)
    transactions
        .sort((a, b) => double.parse(b.fee).compareTo(double.parse(a.fee)));
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CustomText(
                    label: 'Statistics',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        labelColor: Colors.black),

                  CustomText(
                    label: 'Graphical Representation',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    labelColor: Colors.black45,
                    ),
                  SizedBox(height: 20),
                  PieChartWidget(dataMap: dataMap),

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          label: 'All Transactions',
                              labelColor: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        Icon(
                          Icons.swap_vert,
                          size: 25,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                      title: Text(
                        transactions[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        transactions[index].time,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Text(
                        transactions[index].fee,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ));
                },
                childCount: transactions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String name;
  final String time;
  final String fee;
  final bool buy;

  Transaction({
    required this.name,
    required this.time,
    required this.fee,
    required this.buy,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      name: json['name'] as String,
      time: json['time'] as String,
      fee: json['fee'] as String,
      buy: json['buy'] as bool,
    );
  }
}
