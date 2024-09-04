// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventory/Widgets/custom_text_field.dart';
import 'package:inventory/Widgets/elevated_button.dart';
import '../../../Constants/controllers.dart';
import '../../../Helpers/responsiveness.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/dropdown.dart';
import '../../../api_services/addbox_service.dart';
import 'vendor_search.dart';

class BoxAddPage extends StatefulWidget {
  const BoxAddPage({super.key});

  @override
  State<BoxAddPage> createState() => _BoxAddPageState();
}

class _BoxAddPageState extends State<BoxAddPage> {
  final GlobalKey<VendorSearchState> vendorSearchKey =
      GlobalKey<VendorSearchState>();
  final GlobalKey<VendorSearchState> vendorSearchKey2 =
      GlobalKey<VendorSearchState>();
  final AddBoxController addBoxController = Get.put(AddBoxController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: CustomText(
                        text: menuController.activeItem.value,
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Supplier Details',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    Row(children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 8.0, bottom: 4.0),
                              child: Text(
                                'Supplier Name',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            VendorSearch(
                                key: vendorSearchKey,
                                controller: addBoxController.supplierName),
                          ],
                        ),
                      ),
                      // Flexible(
                      //   child: CustomTextField(
                      //     textEditingController: addBoxController.supplierName,
                      //     fieldTitle: "Supplier Name",
                      //   ),
                      // ),
                      const SizedBox(width: 50),
                      Flexible(
                        child: CustomTextField(
                          textEditingController: addBoxController.date,
                          fieldTitle: 'Date',
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            size: 20,
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null &&
                                pickedDate != DateTime.now()) {
                              // Format the selected date as needed
                              String formattedDate =
                                  "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                              // Update the text field with the selected date
                              addBoxController.date.text = formattedDate;
                            }
                          },
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextField(
                            textEditingController: addBoxController.billNo,
                            fieldTitle: "Bill No/Invoice No",
                          ),
                        ),
                        const SizedBox(width: 50),
                        Flexible(
                          child: CustomTextField(
                            textEditingController: addBoxController.poNo,
                            fieldTitle: "Purchase Order No",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Flexible(
                            child: CustomTextField(
                          textEditingController:
                              addBoxController.locationController,
                          // hintText: 'Model Number',
                          fieldTitle: 'Location (From Where)',
                        )),
                        const SizedBox(
                          width: 50,
                        ),
                        Flexible(
                            child: CustomDropDown(
                                items: addBoxController.mosList,
                                val: addBoxController.selectedMos.value,
                                onChanged: (newValue) {
                                  setState(() {
                                    addBoxController.selectedMos.value =
                                        newValue!;
                                  });
                                },
                                fieldTitle: 'Mode of Shipment')),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, top: 8.0, bottom: 4.0),
                                child: Text(
                                  'Reciever Name',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              VendorSearch(
                                  key: vendorSearchKey2,
                                  controller: addBoxController.reciever),
                            ],
                          ),
                        ),
                        // Flexible(
                        //   child: CustomTextField(
                        //     textEditingController: addBoxController.reciever,
                        //     fieldTitle: "Reciever Name",
                        //   ),
                        // ),
                        const SizedBox(width: 50),
                        Flexible(
                          child: CustomTextField(
                            textEditingController: addBoxController.remark,
                            fieldTitle: "Remark",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Details',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: CustomTextField(
                            textEditingController: addBoxController.productName,
                            fieldTitle: "Product Name",
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                child: CustomTextField(
                                  textEditingController: addBoxController.qty,
                                  fieldTitle: "qty",
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: Button(
                                    onPressed: () {
                                      if (addBoxController
                                              .qty.text.isNotEmpty &&
                                          addBoxController
                                              .productName.text.isNotEmpty) {
                                        // int qty = int.parse(_qty.text);
                                        setState(() {
                                          addBoxController.list.add({
                                            'name': addBoxController
                                                .productName.text,
                                            'qty': addBoxController.qty.text,
                                          });
                                          addBoxController.productName.clear();
                                          addBoxController.qty.clear();
                                        });
                                      }
                                    },
                                    text: "Add"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    addBoxController.list.isEmpty
                        ? const SizedBox()
                        : SingleChildScrollView(
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                    label: Text('ID',
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center)),
                                DataColumn(
                                    label: Text('Name',
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center)),
                                DataColumn(
                                    label: Text('Qty',
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center)),
                                DataColumn(
                                    label: Text('Action',
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center)),
                              ],
                              rows: List<DataRow>.generate(
                                  addBoxController.list.length,
                                  (index) => DataRow(cells: [
                                        DataCell(Text("${index + 1}")),
                                        DataCell(Text(
                                            "${addBoxController.list[index]['name']}")),
                                        DataCell(Text(
                                            "${addBoxController.list[index]['qty']}")),
                                        DataCell(
                                          IconButton(
                                            icon: Icon(
                                                Icons.remove_circle_outline),
                                            color: Colors.red,
                                            onPressed: () {},
                                          ),
                                        ),
                                      ])),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Button(
                            onPressed: () async {
                              if (addBoxController.billNo.text.isNotEmpty &&
                                  addBoxController.date.text.isNotEmpty &&
                                  addBoxController.poNo.text.isNotEmpty &&
                                  addBoxController.reciever.text.isNotEmpty &&
                                  addBoxController.remark.text.isNotEmpty &&
                                  addBoxController
                                      .supplierName.text.isNotEmpty &&
                                  addBoxController
                                      .locationController.text.isNotEmpty &&
                                  addBoxController.selectedMos.isNotEmpty &&
                                  addBoxController.list.isNotEmpty) {
                                String status = await addBoxController.save();
                                if (status == 'ok') {
                                  setState(() {
                                    addBoxController.billNo.clear();
                                    addBoxController.date.clear();
                                    addBoxController.poNo.clear();
                                    addBoxController.reciever.clear();
                                    addBoxController.remark.clear();
                                    addBoxController.supplierName.clear();
                                    addBoxController.locationController.clear();
                                    addBoxController.selectedMos;
                                    addBoxController.list.clear();
                                  });
                                }
                              } else {}
                            },
                            text: "Submit"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
