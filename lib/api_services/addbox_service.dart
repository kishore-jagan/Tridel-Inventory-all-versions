// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/toaster.dart';
import 'api_config.dart';

class AddBoxController extends GetxController {
  final TextEditingController supplierName = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController billNo = TextEditingController();
  final TextEditingController poNo = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController reciever = TextEditingController();
  final TextEditingController remark = TextEditingController();
  final TextEditingController productName = TextEditingController();
  final TextEditingController qty = TextEditingController();

  String selectedMos = "ByRoad";
  List<String> mosList = ["ByRoad", "ByAir", "ByTrain", "ByShip"];

  final List<Map<String, dynamic>> list = [];
  final int count = 1;

  RxBool isLoading = false.obs;

  Future<String> save() async {
    try {
      isLoading.value = true;
      String productList = jsonEncode(list);

      // Prepare the request body
      var requestBody = {
        "billNo": billNo.text,
        "poNo": poNo.text,
        "date": date.text,
        "supplierName": supplierName.text,
        "location": locationController.text,
        "mos": selectedMos,
        "remark": remark.text,
        "recieverName": reciever.text,
        "products": productList, // Pass the JSON string here
      };

      // Send the POST request
      var response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}${ApiConfig.saveBox}"),
        body: jsonEncode(requestBody),
      );

      // Decode the response
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Toaster().showsToast(data['message'], Colors.green, Colors.white);
        // Get.snackbar("Success", "${data['message']}");
        // BoxController().fetchBoxes();
        return "ok";
      } else {
        Toaster().showsToast(data['message'], Colors.red, Colors.white);
        // Get.snackbar("error", "${data['message']}");
        return "bad";
      }
    } catch (e) {
      Toaster()
          .showsToast('Error: Something went wrong', Colors.red, Colors.white);
      print('$e');
      return "bad";
    }
    // Convert the list of products to a JSON string
  }
}
