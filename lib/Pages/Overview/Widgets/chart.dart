import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      } else {
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
                      '${sales.name}\nQty: ${sales.qty}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
              primaryXAxis: DateTimeAxis(
                title: AxisTitle(
                    text: 'Date Wise',
                    textStyle:
                        TextStyle(color: Colors.lightBlue, fontSize: 20)),
                intervalType: DateTimeIntervalType.days,
                interval: 1,
                labelRotation: -47,
              ),
              series: <CartesianSeries<SalesData, String>>[
                StackedColumnSeries<SalesData, String>(
                    dataSource: ChartController().data,
                    xValueMapper: (SalesData sales, _) => sales.name,
                    yValueMapper: (SalesData sales, _) => sales.qty,
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
        );
      }
    });
  }
}
