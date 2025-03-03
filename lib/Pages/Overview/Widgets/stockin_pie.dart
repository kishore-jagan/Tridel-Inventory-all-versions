import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/api_services/products_service_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Widgets/custom_text.dart';

class StockinCategoryPie extends StatelessWidget {
  StockinCategoryPie({super.key});
  final ProductsController productsController = Get.put(ProductsController());
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

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
      if (productsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final List<StockinData> data = productsController.categotyChart;
        // print('Fetched Data: ${productsController.data}');

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
                    text: "Stock In Chart",
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
                        final StockinData sales = data;
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
                    series: <PieSeries<StockinData, String>>[
                      PieSeries<StockinData, String>(
                        dataSource: data,
                        xValueMapper: (StockinData data, _) => data.name,
                        yValueMapper: (StockinData data, _) => data.qty,
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
                        pointColorMapper: (StockinData data, _) =>
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
