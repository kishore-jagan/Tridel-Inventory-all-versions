// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inventory/Constants/style.dart';
import 'package:inventory/Pages/Overview/Widgets/stockin_pie.dart';

import '../../../Constants/constants.dart';
import 'StockoutColumnChart.dart';
import 'StockoutSplineChart.dart';
import 'stockout_pie.dart';

class RevenueSectionLarge extends StatelessWidget {
  // final RevenueService revenueService = Get.put(RevenueService());

  // final Map<String, Color> categoryColors = {
  //   'Electrical': electrical,
  //   'Mechanical': mechanical,
  //   'IT': it,
  //   'Finance': finance,
  //   'Consumables': consumables
  // };

  @override
  Widget build(BuildContext context) {
    return
        // GetX<RevenueService>(
        //     init: revenueService,
        //     initState: (state) {
        //       WidgetsBinding.instance.addPostFrameCallback((_) {
        //         revenueService.fetchAndCalculateRevenue();
        //       });
        //     },
        //     builder: (revenueService) {
        //       if (revenueService.isLoading.value) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else {
        //         return
        Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 245, 255),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: lightGray.withOpacity(.1),
                blurRadius: 12)
          ],
          border: Border.all(color: splineColor, width: .5)),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: categoryColors.entries.map((entry) {
          //     return Row(
          //       children: [
          //         Container(
          //           width: 16,
          //           height: 16,
          //           color: entry.value,
          //         ),
          //         const SizedBox(width: 8),
          //         Text(entry.key, style: const TextStyle(fontSize: 16)),
          //       ],
          //     );
          //   }).toList(),
          // ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(child: StockinCategoryPie()),
              Expanded(child: StockoutCategoryPie()),
              // Expanded(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Row(
              //         children: [
              //           RevenueInfo(
              //             title: "Today's revenue",
              //             amount: revenueService.revenue.value.today
              //                 .toStringAsFixed(2),
              //           ),
              //           RevenueInfo(
              //             title: "Last 7 days",
              //             amount: revenueService.revenue.value.last7Days
              //                 .toStringAsFixed(2),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 30,
              //       ),
              //       Row(
              //         children: [
              //           RevenueInfo(
              //             title: "Last 30 days",
              //             amount: revenueService
              //                 .revenue.value.last30Days
              //                 .toStringAsFixed(2),
              //           ),
              //           RevenueInfo(
              //             title: "Last 12 months",
              //             amount: revenueService
              //                 .revenue.value.last12Months
              //                 .toStringAsFixed(2),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          StockoutSplineChart(),
          const SizedBox(
            height: defaultPadding,
          ),
          StockoutColumnChart(),
        ],
      ),
    );
  }
}
//         );
//   }
// }
