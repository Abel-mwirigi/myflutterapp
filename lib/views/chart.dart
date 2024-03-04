import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _chartState();
}

class _chartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 700,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <SplineSeries<SalesData, String>>[
              SplineSeries<SalesData, String>(
                color: Color.fromARGB(255, 47, 125, 121),
                dataSource: <SalesData>[
                  SalesData('Jan', 100),
                  SalesData('Feb', 20),
                  SalesData('Mar', 40),
                  SalesData('Apr', 15),
                  SalesData('May', 5)
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
              )
            ]),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
