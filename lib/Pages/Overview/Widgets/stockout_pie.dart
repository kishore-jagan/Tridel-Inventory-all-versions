import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/api_services/chart_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Widgets/custom_text.dart';

class StockoutCategoryPie extends StatelessWidget {
  StockoutCategoryPie({super.key});
  final ChartController chartController = Get.put(ChartController());

  final Map<String, Color> categoryColors = {
    'Electrical': electrical,
    'Mechanical': mechanical,
    'IT': it,
    'Accounts': accounts,
    'Admin': admin,
    'General': general
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chartController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final List<SalesData> data = chartController.categoryChart;
        // print('Fetched Data: ${chartController.data}');

        if (data.isEmpty) {
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
                    text: "Stock Out Chart",
                    size: 20,
                    weight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                  const SizedBox(height: defaultPadding),
                  SfCircularChart(
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
                            '${sales.name}\nQty: ${sales.qty}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                    series: <PieSeries<SalesData, String>>[
                      PieSeries<SalesData, String>(
                        dataSource: data,
                        xValueMapper: (SalesData data, _) => data.name,
                        yValueMapper: (SalesData data, _) => data.qty,
                        dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                                fontSize: 14,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold),
                            labelPosition: ChartDataLabelPosition.outside),

                        explode: true,
                        explodeIndex: 0,
                        // Adding gradient color to pie chart
                        pointColorMapper: (SalesData data, _) =>
                            categoryColors[data.name] ?? Colors.grey,
                      ),
                    ],
                    legend: const Legend(
                        isVisible: true,
                        position: LegendPosition.left,
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        iconHeight: 20,
                        iconWidth: 20),
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
