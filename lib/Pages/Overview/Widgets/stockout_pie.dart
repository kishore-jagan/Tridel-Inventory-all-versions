import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/api_services/chart_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Widgets/custom_text.dart';

class StockoutPie extends StatelessWidget {
  StockoutPie({super.key});
  final ChartController chartController = Get.put(ChartController());

  // final Map<String, Color> categoryColors = {
  //   'GeoScience': geoScience,
  //   'GeoInformatics': geoInformatics,
  //   'GeoEngineering': geoEngineering,
  //   'ESS': ess,
  // };

  final Map<String, Color> categoryColors = {
    'Electrical': electrical,
    'Mechanical': mechanical,
    'IT': it,
    'Finance': finance,
    'Consumables': consumables
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chartController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final List<SalesData> data = chartController.categoryChart;
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
                    text: "Stock Out Chart",
                    size: 20,
                    weight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                  SizedBox(height: defaultPadding),
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
                    legend: Legend(
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
