// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Constants/controllers.dart';
import 'package:inventory/Pages/Inventory/widgets/vendor_search.dart';
import 'package:inventory/Widgets/custom_button.dart';
import 'package:inventory/Widgets/custom_search_field.dart';
import 'package:inventory/Widgets/custom_text.dart';
import 'package:inventory/Widgets/elevated_button.dart';
import 'package:inventory/api_services/dispatch_service_controller.dart';
import '../../../api_services/products_service_controller.dart';
import '../../Constants/toaster.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Widgets/dropdown.dart';
import '../../helpers/responsiveness.dart';
import '../Inventory/widgets/receiver_search.dart';
import 'Widget/dispatchList_products.dart';
import 'Widget/editProduct_popup.dart';

class DispatchPage extends StatefulWidget {
  const DispatchPage({super.key});

  @override
  State<DispatchPage> createState() => _DispatchPageState();
}

class _DispatchPageState extends State<DispatchPage> {
  final ProductsController productsController = Get.put(ProductsController());

  final DispatchController dispatchController = Get.put(DispatchController());

  final GlobalKey<VendorSearchState> customerSearchKey =
      GlobalKey<VendorSearchState>();

  final GlobalKey<ReceiverSearchState> senderSearchKey =
      GlobalKey<ReceiverSearchState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (dispatchController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top:
                              ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: menuController.activeItem.value,
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      width: 400,
                      child: CustomSearchField(
                        radius: const BorderRadius.all(Radius.circular(10)),
                        onChanged: (value) {
                          setState(() {
                            dispatchController.searchQuery.value = value;
                          });
                        },
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        Get.to(() => DispatchedProductsPage());
                      },
                      text: 'Dispatched List',
                      icon: Icons.arrow_forward,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(children: [
                    const SizedBox(height: 10),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._buildCategoryList(),
                            const SizedBox(
                              height: 20,
                            ),
                            _buildSelectedProductsList(context),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 8.0, bottom: 4.0),
                                        child: Text(
                                          'Customer name',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                      VendorSearch(
                                        key: customerSearchKey,
                                        controller: dispatchController
                                            .customerNameController,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                    child: CustomTextField(
                                  fieldTitle: 'Invoice/Delivery note',
                                  textEditingController:
                                      dispatchController.invoiceController,
                                  // hintText: 'Enter Product Name',
                                )),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Flexible(
                                    child: CustomTextField(
                                  textEditingController:
                                      dispatchController.pnoController,
                                  fieldTitle: 'Project No',
                                )),
                                const SizedBox(width: 50),
                                Flexible(
                                    child: CustomDropDown(
                                        items: dispatchController.mosList,
                                        val: dispatchController.selectedMos,
                                        onChanged: (newValue) {
                                          setState(() {
                                            dispatchController.selectedMos =
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 8.0, bottom: 4.0),
                                        child: Text(
                                          'Sender name',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                      ReceiverSearch(
                                        key: senderSearchKey,
                                        controller: dispatchController
                                            .senderNameController,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Flexible(
                                  child: CustomTextField(
                                    fieldTitle: 'Remarks',
                                    textEditingController: dispatchController
                                        .dispatchRemarksController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Button(
                                onPressed: () async {
                                  dispatchController.isLoading.value = true;
                                  if (dispatchController.customerNameController
                                          .text.isNotEmpty &&
                                      dispatchController
                                          .invoiceController.text.isNotEmpty &&
                                      dispatchController
                                          .pnoController.text.isNotEmpty &&
                                      dispatchController.senderNameController
                                          .text.isNotEmpty &&
                                      dispatchController
                                          .dispatchRemarksController
                                          .text
                                          .isNotEmpty &&
                                      dispatchController
                                          .selectedProducts.isNotEmpty) {
                                    String status = await dispatchController
                                        .dispatchProducts();
                                    if (status == 'ok') {
                                      dispatchController.customerNameController
                                          .clear();
                                      dispatchController.invoiceController
                                          .clear();
                                      dispatchController.pnoController.clear();
                                      dispatchController.senderNameController
                                          .clear();
                                      dispatchController
                                          .dispatchRemarksController
                                          .clear();
                                      dispatchController.selectedProducts
                                          .clear();
                                    }
                                  } else {
                                    dispatchController.isLoading.value = false;
                                    print("null value handled");
                                    Toaster().showsToast(
                                        'Please fill all fields',
                                        Colors.red,
                                        Colors.white);
                                  }
                                },
                                text: 'Dispatch'),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildCategoryList() {
    Map<String, List<Map<String, dynamic>>> categorizedProducts = {};

    String searchQuery = dispatchController.searchQuery.value.toLowerCase();
    List<dynamic> filteredProducts =
        productsController.dataListProduct.where((product) {
      String name = product['name'].toString().toLowerCase();
      String modelNo = product['model_no'].toString().toLowerCase();
      return name.contains(searchQuery) || modelNo.contains(searchQuery);
    }).toList();

    for (var product in filteredProducts) {
      String category = product['category'];
      if (!categorizedProducts.containsKey(category)) {
        categorizedProducts[category] = [];
      }
      categorizedProducts[category]!.add(product);
    }

    List<Widget> categoryList = [];
    categorizedProducts.forEach((category, products) {
      categoryList.add(
        ExpansionTile(
          title: Text(category,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          children: products.map((product) {
            bool isSelected =
                dispatchController.selectedProducts.contains(product);
            return ListTile(
              title: Text(product['name']),
              subtitle: Text('Model No: ${product['model_no']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      if (value == true) {
                        dispatchController.selectedProducts.add(product);
                      } else {
                        dispatchController.selectedProducts.remove(product);
                      }
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });

    return categoryList;
  }

  Widget _buildSelectedProductsList(BuildContext context) {
    return Obx(
      () {
        if (dispatchController.selectedProducts.isEmpty) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No products selected',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
              Divider(),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Products:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Column(
              children: dispatchController.selectedProducts.map((product) {
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text('Model No: ${product['model_no']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditPopup(context, product);
                          // Get.to(() => EditProductPage(product: product));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.red,
                        onPressed: () {
                          dispatchController.selectedProducts.remove(product);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

void _showEditPopup(BuildContext context, Map<String, dynamic> product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditProductPopup(
        product: product,
      );
    },
  );
}
