// ignore_for_file: avoid_print, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventory/Widgets/custom_text_field.dart';
import 'package:inventory/Widgets/dropdown.dart';
import 'package:inventory/Widgets/elevated_button.dart';
import 'package:inventory/api_services/addinventory_service.dart';
import 'package:inventory/api_services/boxController.dart';

import '../../Constants/controllers.dart';
import '../../Constants/toaster.dart';
import '../../Widgets/custom_text.dart';
import '../../api_services/products_service_controller.dart';
import '../../api_services/update_box_service.dart';
import '../../helpers/responsiveness.dart';

class InventoryPage extends StatefulWidget {
  final String token;
  final String name;
  final String qty;
  final String billNo;
  final String poNo;
  final String supplierName;
  final String recieverName;
  final String location;
  final String mos;
  const InventoryPage({
    super.key,
    required this.name,
    required this.qty,
    required this.token,
    required this.billNo,
    required this.poNo,
    required this.supplierName,
    required this.recieverName,
    required this.location,
    required this.mos,
  });

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final ProductsController productsController = Get.put(ProductsController());
  final InventoryController inventoryController =
      Get.put(InventoryController());
  // final GlobalKey<VendorSearch2State> vendorSearchKey2 =
  //     GlobalKey<VendorSearch2State>();
  final BoxController _box = Get.put(BoxController());

  @override
  void initState() {
    super.initState();
    inventoryController.nameController.text = widget.name;
    inventoryController.qtyController.text = widget.qty;
    inventoryController.pPoController.text = widget.poNo;
    inventoryController.pInvoiceController.text = widget.billNo;
    inventoryController.vendorNameController.text = widget.supplierName;
    inventoryController.receiversController.text = widget.recieverName;
    inventoryController.placeController.text = widget.location;
    inventoryController.selectedMos = widget.mos;
    print(widget.supplierName);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // Reassign values or force rebuild if necessary
        print("Vendor: == ${inventoryController.vendorNameController.text}");
        print("Receiver: == ${inventoryController.receiversController.text}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => inventoryController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ))
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: ResponsiveWidget.isSmallScreen(context)
                                  ? 56
                                  : 6),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: menuController.activeItem.value,
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                offset: const Offset(0, 2),
                                blurRadius: 2)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Item Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: CustomTextField(
                                  fieldTitle: 'Product Name',
                                  textEditingController:
                                      inventoryController.nameController,
                                  // hintText: 'Enter Product Name',
                                )),
                                const SizedBox(width: 50),
                                Flexible(
                                    child: CustomTextField(
                                  textEditingController:
                                      inventoryController.serialController,
                                  // hintText: 'Model Number',
                                  fieldTitle: 'Enter Serial Number',
                                )),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Flexible(
                                    child: CustomTextField(
                                  textEditingController:
                                      inventoryController.modelController,
                                  // hintText: 'Model Number',
                                  fieldTitle: 'Enter Model Number',
                                )),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: CustomTextField(
                                        textEditingController:
                                            inventoryController.qtyController,
                                        fieldTitle: 'Enter Quantity',
                                        keyboard: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        textInput: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}$'),
                                          ),
                                        ],
                                      )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                          child: CustomTextField(
                                        textEditingController:
                                            inventoryController.priceController,
                                        fieldTitle: 'Enter Price',
                                        keyboard: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        textInput: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}$'),
                                          ),
                                        ],
                                      )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Flexible(
                                  child: CustomDropDown(
                                    fieldTitle: 'Main Category',
                                    items:
                                        inventoryController.mainCategoriesList,
                                    val: inventoryController
                                        .selectedMainCategory.value,
                                    onChanged: (newValue) {
                                      setState(() {
                                        inventoryController.selectedMainCategory
                                            .value = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Flexible(
                                  child: CustomDropDown(
                                      fieldTitle: 'Category',
                                      items: inventoryController.categoriesList,
                                      val: inventoryController
                                          .selectedCategory.value,
                                      onChanged: (newValue) {
                                        setState(() {
                                          inventoryController.selectedCategory
                                              .value = newValue!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                    child: CustomDropDown(
                                        items: inventoryController.typeList,
                                        val: inventoryController
                                            .selectedType.value,
                                        onChanged: (newValue) {
                                          setState(() {
                                            inventoryController
                                                .selectedType.value = newValue!;
                                          });
                                        },
                                        fieldTitle: 'Type')),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: CustomDropDown(
                                        items: inventoryController.locationList,
                                        val: inventoryController
                                            .selectedLocation.value,
                                        onChanged: (newValue) {
                                          setState(() {
                                            inventoryController.selectedLocation
                                                .value = newValue!;
                                          });
                                        },
                                        fieldTitle: 'Location')),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                    child: CustomDropDown(
                                        items:
                                            inventoryController.returnableList,
                                        val: inventoryController
                                            .selectedReturnable.value,
                                        onChanged: (newValue) {
                                          setState(() {
                                            inventoryController
                                                .selectedReturnable
                                                .value = newValue!;
                                          });
                                        },
                                        fieldTitle: 'Returnable')),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                    child: CustomTextField(
                                        textEditingController:
                                            inventoryController
                                                .itemRemarksController,
                                        fieldTitle: 'Remarks'))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (inventoryController.selectedMainCategory != 'ESS')
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  offset: const Offset(0, 2),
                                  blurRadius: 2)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Project Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 24),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      child: CustomTextField(
                                    fieldTitle: 'Project Name',
                                    textEditingController:
                                        inventoryController.pNameController,
                                    // hintText: 'Enter Product Name',
                                  )),
                                  const SizedBox(width: 50),
                                  Flexible(
                                      child: CustomTextField(
                                    textEditingController:
                                        inventoryController.pNoController,
                                    // hintText: 'Model Number',
                                    fieldTitle: 'Project Number',
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Flexible(
                                      child: CustomTextField(
                                    textEditingController:
                                        inventoryController.pPoController,
                                    // hintText: 'Model Number',
                                    fieldTitle: 'Purchase Order',
                                  )),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Flexible(
                                      child: CustomTextField(
                                    textEditingController:
                                        inventoryController.pInvoiceController,
                                    // hintText: 'Model Number',
                                    fieldTitle: 'Invoice Number',
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                offset: const Offset(0, 2),
                                blurRadius: 2)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vendor Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: CustomTextField(
                                  textEditingController:
                                      inventoryController.vendorNameController,
                                  // hintText: 'Model Number',
                                  fieldTitle: 'Supplier Name',
                                )),
                                // Flexible(
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       const SizedBox(
                                //         height: 10,
                                //       ),
                                //       const Padding(
                                //         padding: EdgeInsets.only(
                                //             left: 10.0, top: 8.0, bottom: 4.0),
                                //         child: Text(
                                //           'Vendor name',
                                //           style: TextStyle(fontSize: 16.0),
                                //         ),
                                //       ),
                                //       VendorSearch2(
                                //           key: vendorSearchKey2,
                                //           controller: inventoryController
                                //               .vendorNameController),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                  child: CustomTextField(
                                    textEditingController:
                                        inventoryController.dateController,
                                    fieldTitle: 'Date',
                                    suffixIcon: const Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
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
                                        inventoryController.dateController
                                            .text = formattedDate;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: CustomTextField(
                                  textEditingController:
                                      inventoryController.placeController,
                                  // hintText: 'Model Number',
                                  fieldTitle: 'Location',
                                )),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                    child: CustomDropDown(
                                        items: inventoryController.mosList,
                                        val: inventoryController.selectedMos,
                                        onChanged: (newValue) {
                                          setState(() {
                                            inventoryController.selectedMos =
                                                newValue!;
                                          });
                                        },
                                        fieldTitle: 'Mode of Shipment')),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: CustomTextField(
                                  textEditingController:
                                      inventoryController.receiversController,
                                  // hintText: 'Model Number',
                                  fieldTitle: 'Receiver Name',
                                )),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                  child: CustomTextField(
                                      textEditingController: inventoryController
                                          .vendorRemarksController,
                                      fieldTitle: 'Remarks'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Button(
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      // vendorSearchKey.currentState
                                      //     .setSelectedVendor();
                                    });
                                    inventoryController.isLoading.value = true;
                                    if (inventoryController
                                            .selectedMainCategory.value ==
                                        "ESS") {
                                      inventoryController.pNameController.text =
                                          inventoryController
                                                  .pNameController.text.isEmpty
                                              ? 'Not assigned'
                                              : inventoryController
                                                  .pNameController.text;
                                      inventoryController.pNoController.text =
                                          inventoryController
                                                  .pNoController.text.isEmpty
                                              ? 'Not assigned'
                                              : inventoryController
                                                  .pNoController.text;
                                      inventoryController.pPoController.text =
                                          inventoryController
                                                  .pPoController.text.isEmpty
                                              ? 'N/A'
                                              : inventoryController
                                                  .pPoController.text;
                                      inventoryController.pInvoiceController
                                          .text = inventoryController
                                              .pInvoiceController.text.isEmpty
                                          ? 'N/A'
                                          : inventoryController
                                              .pInvoiceController.text;
                                    }

                                    if (inventoryController.nameController.text.isNotEmpty &&
                                        inventoryController
                                            .modelController.text.isNotEmpty &&
                                        inventoryController
                                            .serialController.text.isNotEmpty &&
                                        inventoryController
                                            .qtyController.text.isNotEmpty &&
                                        inventoryController
                                            .priceController.text.isNotEmpty &&
                                        inventoryController
                                            .itemRemarksController
                                            .text
                                            .isNotEmpty &&
                                        inventoryController
                                            .pNameController.text.isNotEmpty &&
                                        inventoryController
                                            .pNoController.text.isNotEmpty &&
                                        inventoryController
                                            .pPoController.text.isNotEmpty &&
                                        inventoryController.pInvoiceController
                                            .text.isNotEmpty &&
                                        inventoryController.vendorNameController
                                            .text.isNotEmpty &&
                                        inventoryController
                                            .dateController.text.isNotEmpty &&
                                        inventoryController
                                            .placeController.text.isNotEmpty &&
                                        inventoryController.receiversController
                                            .text.isNotEmpty &&
                                        inventoryController
                                            .vendorRemarksController
                                            .text
                                            .isNotEmpty) {
                                      print("Started");

                                      // String status =
                                      String stat =
                                          await inventoryController.saveData();
                                      print(stat);
                                      if (stat == 'ok') {
                                        productsController.fetchListProducts();
                                        // Get.back(result: "true");
                                        _box.boxes.clear();
                                        bool status = await UpdateBox()
                                            .boxUpdate(widget.name, widget.qty,
                                                widget.token);
                                        if (status) {
                                          print("status : === $status");
                                          Get.snackbar("Success",
                                              "Details updated Successfully");
                                          productsController
                                              .fetchListProducts();
                                          inventoryController.clearFields();
                                          _box.fetchBoxes();
                                          Get.back();
                                          Navigator.pop(context);
                                          print("End");
                                        }
                                      }

                                      // if (status == 'ok') {
                                      //   setState(() {
                                      //     Get.back();
                                      //   });
                                      // } else {}

                                      print("End");
                                    } else {
                                      inventoryController.isLoading.value =
                                          false;
                                      print("null value handled");
                                      Toaster().showsToast(
                                          'Please fill all fields',
                                          Colors.red,
                                          Colors.white);
                                    }
                                  } catch (e) {
                                    Toaster().showsToast('Something went wrong',
                                        Colors.red, Colors.white);
                                    print('error: $e');
                                    inventoryController.isLoading.value = false;
                                  }
                                },
                                text: "Add"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}
