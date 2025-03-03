// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Pages/Inventory/inventory.dart';
import 'package:inventory/Widgets/custom_text.dart';
import 'package:inventory/Widgets/elevated_button.dart';
import 'package:inventory/api_services/boxController.dart';

import '../../Constants/controllers.dart';
import '../../Constants/style.dart';
import '../../Helpers/responsiveness.dart';
import '../../model/box_model.dart';

class Pendingtask extends StatefulWidget {
  const Pendingtask({super.key});

  @override
  State<Pendingtask> createState() => _PendingtaskState();
}

class _PendingtaskState extends State<Pendingtask> {
  final BoxController _box = Get.put(BoxController());
  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();
  final Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();

    _box.fetchBoxes();
  }

  List<DataColumn> column = const [
    // const DataColumn(label: Text("Id")),
    // const DataColumn(label: Text("Date")),
    // const DataColumn(label: Text("Bill No")),
    // const DataColumn(label: Text("Po No")),
    // const DataColumn(label: Text("Supplier Name")),
    // const DataColumn(label: Text("Reciever")),
    // const DataColumn(label: Text("Remark")),
    // const DataColumn(label: Text("Status")),
    DataColumn(
        label: Text('ID',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
        label: Text('SupplierName',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
        label: Text('Bill No',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
        label: Text('PO No',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
        label: Text('Date',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
        label: Text('Reciever',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
        label: Text('Location',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
        label: Text('MOS',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    DataColumn(
      label: Text('Remark',
          style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
    ),
    DataColumn(
      label: Text('Status',
          style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var box = _box.boxes;
    return Column(
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
        Expanded(
          child: Obx(() {
            if (_box.boxes.isEmpty) {
              return const CircularProgressIndicator();
            }
            return Container(
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
                child: SingleChildScrollView(
                  controller: verticalScrollController,
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    controller: horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columnSpacing: ResponsiveWidget.isLargeScreen(context)
                            ? MediaQuery.of(context).size.width / 26
                            : ResponsiveWidget.isCustomScreen(context)
                                ? MediaQuery.of(context).size.width / 52
                                : ResponsiveWidget.isMediumScreen(context)
                                    ? MediaQuery.of(context).size.width / 120
                                    : MediaQuery.of(context).size.width / 120,
                        horizontalMargin:
                            ResponsiveWidget.isLargeScreen(context) ? 30 : 10,
                        columns: column,
                        rows: List<DataRow>.generate(
                            box.length,
                            (index) => DataRow(cells: [
                                  DataCell(Center(
                                    child: CustomText(text: "${index + 1}"),
                                  )),
                                  DataCell(CustomText(
                                      text: box[index].supplierName)),
                                  DataCell(CustomText(text: box[index].billNo)),
                                  DataCell(CustomText(text: box[index].poNo)),
                                  DataCell(CustomText(text: box[index].date)),
                                  DataCell(CustomText(
                                      text: box[index].recieverName)),
                                  DataCell(
                                      CustomText(text: box[index].location)),
                                  DataCell(CustomText(text: box[index].mos)),
                                  DataCell(CustomText(text: box[index].remark)),
                                  // DataCell(Text("${index + 1}")),
                                  // DataCell(Text(box[index].supplierName)),
                                  // DataCell(Text(box[index].billNo)),
                                  // DataCell(Text(box[index].poNo)),
                                  // DataCell(Text(box[index].date)),
                                  // DataCell(Text(box[index].recieverName)),
                                  // DataCell(Text(box[index].remark)),
                                  DataCell(box[index].status == '0'
                                      ? InkWell(
                                          onTap: () async {
                                            Map<String, dynamic>? data =
                                                await showSheet(
                                                    box[index].products,
                                                    box[index].token);

                                            if (data!.isNotEmpty) {
                                              bool val = await Navigator.of(
                                                      context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          InventoryPage(
                                                            name: data['name'],
                                                            token:
                                                                data['token'],
                                                            qty: data['qty'],
                                                            billNo:
                                                                data['billNo'],
                                                            poNo: data['poNo'],
                                                            supplierName: data[
                                                                'supplierName'],
                                                            recieverName: data[
                                                                'recieverName'],
                                                            location: data[
                                                                'location'],
                                                            mos: data['mos'],
                                                          )));
                                              if (val == true) {
                                                print("true");
                                                setState(() {
                                                  data.clear();
                                                  _box.boxes.clear();
                                                  _box.fetchBoxes();
                                                });
                                              }
                                            }
                                          },
                                          child: const Icon(
                                            CupertinoIcons
                                                .exclamationmark_circle_fill,
                                            color: Colors.red,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )),
                                ]))),
                  ),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  Future<Map<String, dynamic>?> showSheet(
    List<Produc> product,
    String token,
  ) async {
    int? isSelected;
    final Map<String, dynamic> data = {};

    return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 300,
                width: 500,
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     blurRadius: 15,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Pending Products",
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      const Text(
                        "Select Product which you want to add details",
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: product.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: isSelected == index ? Colors.blue : null,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    isSelected = index;
                                  });
                                },
                                selected: isSelected == index,
                                title: Text(product[index].name),
                                trailing: Text(product[index].qty),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Button(
                            onPressed: () {
                              if (isSelected == null) {
                                return;
                              } else {
                                var selectedBox = _box.boxes.firstWhere((box) =>
                                    box.products
                                        .contains(product[isSelected!]));

                                data.addAll({
                                  'token': token,
                                  'name': product[isSelected!].name,
                                  'qty': product[isSelected!].qty,
                                  'billNo': selectedBox.billNo,
                                  'poNo': selectedBox.poNo,
                                  'supplierName': selectedBox.supplierName,
                                  'recieverName': selectedBox.recieverName,
                                  'location': selectedBox.location,
                                  'mos': selectedBox.mos
                                });
                                print("Selected data: $data");

                                Get.back(result: data);
                                // Pass data back and close the sheet
                              }
                            },
                            text: "Edit",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
