// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory/api_services/chart_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Constants/constants.dart';
import '../../../Widgets/custom_text.dart';

class StockoutColumnChart extends StatelessWidget {
  StockoutColumnChart({super.key});
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
        final DateTime oneMonthAgo = now.subtract(const Duration(days: 30));
        final List<SalesData> lastMonthData = chartController.data
            .where((sales) => sales.date.isAfter(oneMonthAgo))
            .toList();

        // Print statements to verify filtered data
        // print("Total data points: ${chartController.data.length}");
        // print("Data points in the last 30 days: ${lastMonthData.length}");

        // lastMonthData.forEach((data) {
        //   print(
        //       "Date: ${data.date}, Category: ${data.mainCategory}, Qty: ${data.qty}");
        // });
        // final List<SalesData> data = chartController.data;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 2, vertical: defaultPadding),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 238, 250, 255),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              const CustomText(
                text: "StockOut MainCategory",
                size: 20,
                weight: FontWeight.bold,
                color: secondaryColor,
              ),
              const SizedBox(height: defaultPadding),
              SfCartesianChart(
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
                        '${sales.mainCategory}\n${chartController.dateFormat.format(sales.date)}\nQty: ${sales.qty}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
                plotAreaBackgroundColor: Colors.transparent,
                margin: const EdgeInsets.all(0),
                borderColor: Colors.transparent,
                borderWidth: 0,
                plotAreaBorderWidth: 0,
                primaryXAxis: DateTimeAxis(
                  labelPosition: ChartDataLabelPosition.outside,
                  labelAlignment: LabelAlignment.center,
                  // labelPlacement: LabelPlacement.onTicks,
                  labelRotation: -47,
                  axisLine: const AxisLine(width: 0),
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  plotOffset: 5,
                  labelsExtent: 60,
                  labelStyle: const TextStyle(
                      color: secondaryColor,
                      fontFamily: "Roboto",
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                  // title: const AxisTitle(
                  //   text: 'Date',
                  //   textStyle: TextStyle(color: Colors.lightBlue, fontSize: 20),
                  // ),
                  intervalType: DateTimeIntervalType.days,
                  dateFormat:
                      DateFormat('MMM d'), // Use the same date format here
                ),
                primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(width: 0),
                  plotOffset: 5,
                  majorGridLines: MajorGridLines(width: 0),
                  majorTickLines: MajorTickLines(width: 0),
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  labelStyle: TextStyle(
                      color: secondaryColor,
                      fontFamily: "Roboto",
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                  // interval: 5,
                  // title: const AxisTitle(
                  //   text: 'Quantity',
                  //   textStyle: TextStyle(color: Colors.lightBlue, fontSize: 20),
                  // ),
                ),
                series: <ColumnSeries>[
                  ColumnSeries<SalesData, DateTime>(
                    dataSource: lastMonthData
                        .where((sales) => sales.mainCategory == 'GeoScience')
                        .toList(),
                    xValueMapper: (SalesData sales, _) => sales.date,
                    yValueMapper: (SalesData sales, _) => sales.qty,
                    // dataLabelSettings: const DataLabelSettings(isVisible: true),
                    gradient: LinearGradient(
                        colors: [geoScience, secondarybgColor.withAlpha(150)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    // color: Colors.blue,
                    width: 1,
                    // name: 'GeoScience',
                  ),
                  ColumnSeries<SalesData, DateTime>(
                    dataSource: lastMonthData
                        .where(
                            (sales) => sales.mainCategory == 'GeoEngineering')
                        .toList(),
                    xValueMapper: (SalesData sales, _) => sales.date,
                    yValueMapper: (SalesData sales, _) => sales.qty,
                    // dataLabelSettings: const DataLabelSettings(isVisible: true),
                    gradient: LinearGradient(colors: [
                      geoEngineering,
                      secondarybgColor.withAlpha(150)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    // color: Colors.red,
                    // name: 'GeoScience',
                    width: 1,
                  ),
                  ColumnSeries<SalesData, DateTime>(
                    dataSource: lastMonthData
                        .where(
                            (sales) => sales.mainCategory == 'GeoInformatics')
                        .toList(),
                    xValueMapper: (SalesData sales, _) => sales.date,
                    yValueMapper: (SalesData sales, _) => sales.qty,
                    // dataLabelSettings: const DataLabelSettings(isVisible: true),
                    gradient: LinearGradient(colors: [
                      geoInformatics,
                      secondarybgColor.withAlpha(150)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    // color: Colors.green,
                    // name: 'GeoScience',
                    width: 1,
                  ),
                  ColumnSeries<SalesData, DateTime>(
                    dataSource: lastMonthData
                        .where((sales) => sales.mainCategory == 'ESS')
                        .toList(),
                    xValueMapper: (SalesData sales, _) => sales.date,
                    yValueMapper: (SalesData sales, _) => sales.qty,
                    // dataLabelSettings: const DataLabelSettings(isVisible: true),
                    gradient: LinearGradient(
                        colors: [ess, secondarybgColor.withAlpha(150)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    // color: Colors.yellow,
                    // name: 'GeoInformatics',
                    width: 1,
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}
