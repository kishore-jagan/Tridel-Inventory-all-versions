// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/api_services/chart_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Widgets/custom_text.dart';

class StockoutSplineChart extends StatelessWidget {
  StockoutSplineChart({super.key});
  final ChartController chartController = Get.put(ChartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chartController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        // final List<SalesData> data = chartController.data;
        // print('Fetched Data: ${chartController.data}');

        final DateTime now = DateTime.now();
        final DateTime oneMonthAgo = now.subtract(const Duration(days: 30));
        final List<SalesData> lastMonthData = chartController.data
            .where((sales) => sales.date.isAfter(oneMonthAgo))
            .toList();
        // print("Total data points: ${chartController.data.length}");
        // print("Data points in the last 30 days: ${lastMonthData.length}");
        // lastMonthData.forEach((data) {
        //   print(
        //       "Date: ${data.date}, Category: ${data.mainCategory}, Qty: ${data.qty}");
        // });

        if (chartController.data.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 2, vertical: defaultPadding),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 238, 250, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const CustomText(
                    text: "StockOut Product",
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
                            '${sales.name}\n${chartController.dateFormat.format(sales.date)}\nQty: ${sales.qty}',
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
                    primaryXAxis: const CategoryAxis(
                        labelPosition: ChartDataLabelPosition.outside,
                        labelAlignment: LabelAlignment.center,
                        labelPlacement: LabelPlacement.onTicks,
                        labelRotation: -47,
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 0),
                        majorTickLines: MajorTickLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        plotOffset: 5,
                        labelsExtent: 50,
                        labelStyle: TextStyle(
                            color: secondaryColor,
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500)),
                    primaryYAxis: const NumericAxis(
                      // numberFormat: NumberFormat.compactCurrency(symbol: ''),
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
                    ),
                    series: <CartesianSeries<dynamic, dynamic>>[
                      SplineAreaSeries<SalesData, String>(
                          dataSource: lastMonthData,
                          xValueMapper: (SalesData data, _) => data.name,
                          yValueMapper: (SalesData data, _) => data.qty,
                          gradient: LinearGradient(
                              colors: [
                                splineColor,
                                secondarybgColor.withAlpha(150)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      SplineSeries<SalesData, String>(
                        color: splineColor,
                        width: 2,
                        dataSource: lastMonthData,
                        xValueMapper: (SalesData data, _) => data.name,
                        yValueMapper: (SalesData data, _) => data.qty,
                        // markerSettings: MarkerSettings(isVisible: true),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}
