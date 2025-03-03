// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/controllers.dart';
import '../../Constants/style.dart';
import '../../Helpers/responsiveness.dart';
import '../../Widgets/custom_text.dart';
import '../../api_services/products_service_controller.dart';

class ReturnableItemsPage extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    controller.filterData();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: active.withOpacity(.4), width: .5),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  columns: const [
                    DataColumn(
                        label: Text("ID", style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label: Text('Name', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                            Text('Project No', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                            Text('Model No', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                            Text('Serial No', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label: Text('Date', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                            Text('Quantity', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label: Text('Amt', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                            Text('Total Amt', style: TextStyle(fontSize: 20))),
                    DataColumn(
                        label:
                            Text('Returnable', style: TextStyle(fontSize: 20))),
                    // DataColumn(label: Text('ID')),
                    // DataColumn(label: Text('Name')),
                    // DataColumn(label: Text('Quantity')),
                    // DataColumn(label: Text('Returnable')),
                  ],
                  rows: List.generate(controller.returnable.length, (index) {
                    final item = controller.returnable[index];
                    return DataRow(
                      cells: [
                        _buildDataCell((index + 1).toString()),
                        _buildDataCell(item['name']),
                        _buildDataCell(item['project_no']),
                        _buildDataCell(item['model_no']),
                        _buildDataCell(item['serial_no']),
                        _buildDataCell(item['date']),
                        _buildDataCell(item['qty'], centerText: true),
                        _buildDataCell(item['price']),
                        _buildDataCell(item['total_price']),
                        _buildDataCell(item['returnable']),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

DataCell _buildDataCell(String value, {bool centerText = false}) {
  return DataCell(centerText
      ? Center(child: CustomText(text: value))
      : CustomText(text: value));
}
