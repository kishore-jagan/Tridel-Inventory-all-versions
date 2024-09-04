import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/api_services/products_service_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Widgets/custom_text.dart';

class StockinPie extends StatelessWidget {
  StockinPie({super.key});
  final ProductsController productsController = Get.put(ProductsController());
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  final Map<String, Color> categoryColors = {
    'GeoScience': geoScience,
    'GeoInformatics': geoInformatics,
    'GeoEngineering': geoEngineering,
    'Office': office,
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final List<SalesData2> data = productsController.data;
        // print('Fetched Data: ${productsController.data}');

        if (data.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        // print('Chart Data:');
        for (var item in data) {
          // print('Name: ${item.name}, Qty: ${item.qty}');
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
                  CustomText(
                    text: "Stock In Chart",
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
                        final SalesData2 sales = data;
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${sales.name}\n${dateFormat.format(sales.date)}\nQty: ${sales.qty}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                    series: <PieSeries<SalesData2, String>>[
                      PieSeries<SalesData2, String>(
                        dataSource: data,
                        xValueMapper: (SalesData2 data, _) => data.name,
                        yValueMapper: (SalesData2 data, _) => data.qty,
                        // radius: '70%',
                        // explodeAll: true,
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
                        pointColorMapper: (SalesData2 data, _) =>
                            categoryColors[data.mainCategory] ?? Colors.grey,
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


 // Add legend below the chart
            // SizedBox(height: defaultPadding),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 2, vertical: defaultPadding),
            //   decoration: const BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(Radius.circular(10))),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: categoryColors.entries.map((entry) {
            //       return Row(
            //         children: [
            //           Container(
            //             width: 16,
            //             height: 16,
            //             color: entry.value,
            //           ),
            //           const SizedBox(width: 8),
            //           Text(entry.key, style: const TextStyle(fontSize: 16)),
            //         ],
            //       );
            //     }).toList(),
            //   ),
            // ),