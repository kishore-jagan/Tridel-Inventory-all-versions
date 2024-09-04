import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory/api_services/chart_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  Chart({super.key});
  final ChartController chartController = Get.put(ChartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chartController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (chartController.data.isEmpty) {
        return const Center(child: Text('No data available.'));
      } else {
        final DateTime now = DateTime.now();
        final DateTime lastWeek = now.subtract(const Duration(days: 7));
        final List<SalesData> lastWeekData = chartController.data
            .where((sales) => sales.date.isAfter(lastWeek))
            .toList();
        final List<SalesData> data = chartController.data;
        return Center(
          child: SfCartesianChart(
            tooltipBehavior: TooltipBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              builder: (dynamic data, dynamic point, dynamic series,
                  int pointIndex, int seriesIndex) {
                final SalesData sales = data;
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Category: ${sales.mainCategory}\nQty: ${sales.qty}\nDate: ${sales.date}',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
            primaryXAxis: DateTimeAxis(
              title: const AxisTitle(
                text: 'Date',
                textStyle: TextStyle(color: Colors.lightBlue, fontSize: 20),
              ),
              // interval: 1,
              dateFormat:
                  DateFormat('dd/MM/yyyy'), // Use the same date format here
              labelRotation: -45,
            ),
            primaryYAxis: NumericAxis(
              // interval: 5,
              title: const AxisTitle(
                text: 'Quantity',
                textStyle: TextStyle(color: Colors.lightBlue, fontSize: 20),
              ),
            ),
            series: <ColumnSeries>[
              ColumnSeries<SalesData, DateTime>(
                dataSource: data
                    .where((sales) => sales.mainCategory == 'GeoScience')
                    .toList(),
                xValueMapper: (SalesData sales, _) => sales.date,
                yValueMapper: (SalesData sales, _) => sales.qty,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                color: Colors.blue,
                width: 1,
                // name: 'GeoScience',
              ),
              ColumnSeries<SalesData, DateTime>(
                dataSource: data
                    .where((sales) => sales.mainCategory == 'GeoEngineering')
                    .toList(),
                xValueMapper: (SalesData sales, _) => sales.date,
                yValueMapper: (SalesData sales, _) => sales.qty,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                color: Colors.red,
                // name: 'GeoScience',
                width: 1,
              ),
              ColumnSeries<SalesData, DateTime>(
                dataSource: data
                    .where((sales) => sales.mainCategory == 'GeoInformatics')
                    .toList(),
                xValueMapper: (SalesData sales, _) => sales.date,
                yValueMapper: (SalesData sales, _) => sales.qty,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                color: Colors.green,
                // name: 'GeoScience',
                width: 1,
              ),
              ColumnSeries<SalesData, DateTime>(
                dataSource:
                    data.where((sales) => sales.mainCategory == 'ESS').toList(),
                xValueMapper: (SalesData sales, _) => sales.date,
                yValueMapper: (SalesData sales, _) => sales.qty,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                color: Colors.yellow,
                // name: 'GeoInformatics',
              ),
            ],
          ),
        );
      }
    });
  }
}
