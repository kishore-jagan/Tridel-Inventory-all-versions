import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/api_services/chart_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Widgets/custom_text.dart';

class Chart1 extends StatelessWidget {
  Chart1({super.key});
  final ChartController chartController = Get.put(ChartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chartController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final List<SalesData> data = chartController.data;
        print('Fetched Data: ${chartController.data}');

        if (data.isEmpty) {
          return Center(child: Text('No data available.'));
        }
        print('Chart Data:');
        for (var item in data) {
          print('Name: ${item.name}, Qty: ${item.qty}');
        }
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultPadding),
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 2, vertical: defaultPadding),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 250, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  CustomText(
                    text: "StockOut Chart",
                    size: 20,
                    weight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                  SizedBox(height: defaultPadding),
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
                    margin: EdgeInsets.all(0),
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
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
                            color: textColor,
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500)),
                    primaryYAxis: NumericAxis(
                      // numberFormat: NumberFormat.compactCurrency(symbol: ''),
                      axisLine: AxisLine(width: 0),
                      plotOffset: 5,
                      majorGridLines: MajorGridLines(width: 0),
                      majorTickLines: MajorTickLines(width: 0),
                      borderColor: Colors.transparent,
                      borderWidth: 0,
                      labelStyle: TextStyle(
                          color: textColor,
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500),
                      // minimum: data
                      //     .map((e) => e.qty)
                      //     .reduce((a, b) => a < b ? a : b), // Set minimum value
                      // maximum: data
                      //     .map((e) => e.qty)
                      //     .reduce((a, b) => a > b ? a : b), // Set maximum value
                      // interval: (data.map((e) => e.qty).reduce((a, b) => a > b ? a : b) -
                      //         data.map((e) => e.qty).reduce((a, b) => a < b ? a : b)) /
                      // 5, // Set interval based on data range
                    ),
                    series: <CartesianSeries<dynamic, dynamic>>[
                      SplineAreaSeries<SalesData, String>(
                          dataSource: data,
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
                        dataSource: data,
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
