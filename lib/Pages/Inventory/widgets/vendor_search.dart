// ignore_for_file: overridden_fields, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/api_services/vendor_service.dart';

class VendorSearch extends StatefulWidget {
  TextEditingController controller;
  @override
  final GlobalKey<VendorSearchState> key;

  VendorSearch({required this.controller, required this.key}) : super(key: key);

  @override
  State<VendorSearch> createState() => VendorSearchState();
}

class VendorSearchState extends State<VendorSearch> {
  final VendorController vendorController = Get.put(VendorController());

  Future<void> setSelectedVendor() async {
    setState(() {
      vendorController.selectedVendor.value = widget.controller.text;
    });
  }

  @override
  void initState() {
    super.initState();
    vendorController.fetchVendors();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return vendorController.vendorList.where((name) =>
            name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selectedVendorName) {
        setState(() {
          vendorController.selectedVendor.value = selectedVendorName;
          // print('selectedVendor: ${selectedVendor}');
          print('selectedVendorName: $selectedVendorName');
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback? onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: (value) {
              setState(() {
                widget.controller.text = textEditingController.text;
                print('Typed 1: ${widget.controller.text}');
                print('typed 2: ${textEditingController.text}');
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                widget.controller.text = textEditingController.text;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.lightBlue),
              ),
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            onSelected(option);
                            widget.controller.text = option;
                            print('final last: ${widget.controller.text}');
                          });
                        },
                        child: ListTile(
                          title: Text(option),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    widget.controller.clear();
                  });
                },
                icon: const Icon(Icons.cancel))
          ],
        );
      },
    );
  }
}

// class VendorSearch2 extends StatefulWidget {
//   TextEditingController controller;
//   final GlobalKey<VendorSearch2State> key;

//   VendorSearch2({required this.controller, required this.key})
//       : super(key: key);

//   State<VendorSearch2> createState() => VendorSearch2State();
// }

// class VendorSearch2State extends State<VendorSearch2> {
//   final VendorController vendorController = Get.put(VendorController());

//   @override
//   void initState() {
//     super.initState();
//     print("Supplier == ${widget.controller.text}");
//     vendorController.fetchVendors();
//     vendorController.selectedVendor.value = widget.controller.text;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text.isEmpty) {
//           return const Iterable<String>.empty();
//         }
//         return vendorController.vendorList.where((name) =>
//             name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
//       },
//       onSelected: (String selectedVendorName) {
//         setState(() {
//           vendorController.selectedVendor.value = selectedVendorName;
//           widget.controller.text = selectedVendorName;
//         });
//       },
//       fieldViewBuilder: (BuildContext context,
//           TextEditingController textEditingController,
//           FocusNode focusNode,
//           VoidCallback? onFieldSubmitted) {
//         // Assign the widget's controller to the Autocomplete's controller
//         textEditingController.text = widget.controller.text;

//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(20)),
//             color: Colors.grey.withOpacity(0.1),
//           ),
//           child: TextFormField(
//             controller:
//                 widget.controller, // Use the widget's controller directly
//             focusNode: focusNode,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 borderSide: const BorderSide(color: Colors.lightBlue),
//               ),
//             ),
//           ),
//         );
//       },
//       optionsViewBuilder: (BuildContext context,
//           AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Align(
//               alignment: Alignment.topLeft,
//               child: Material(
//                 elevation: 4.0,
//                 child: SizedBox(
//                   height: 200.0,
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(8.0),
//                     itemCount: options.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final String option = options.elementAt(index);
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             onSelected(option);
//                             widget.controller.text = option;
//                           });
//                         },
//                         child: ListTile(
//                           title: Text(option),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//                 onPressed: () {
//                   setState(() {
//                     widget.controller.clear();
//                   });
//                 },
//                 icon: const Icon(Icons.cancel))
//           ],
//         );
//       },
//     );
//   }
// }
