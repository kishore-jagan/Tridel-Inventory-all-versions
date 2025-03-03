// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:inventory/api_services/api_config.dart';
import 'package:http/http.dart' as http;

class ReceiverController extends GetxController {
  var receiver = <Receiver>[].obs;
  RxString selectedReceiver = ''.obs;
  List<String> receiverList = [];
  RxBool isLoading = true.obs;

  Future<void> fetchReceivers() async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}${ApiConfig.fetchReceiver}'));

      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['receivers'] != null) {
          // print("rec   $jsonResponse");
          List<Receiver> receivers = (jsonResponse['receivers'] as List)
              .map((receiverjson) => Receiver.fromJson(receiverjson))
              .toList();
          receiverList = receivers.map((e) => e.receiverName).toList();

          receiver.assignAll(receivers);
          // print('vendorResponse : ${receiver}');
        } else {
          throw Exception('receiver data is null');
        }
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }
}

class Receiver {
  final String id;
  final String receiverName;

  Receiver({required this.id, required this.receiverName});

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(id: json['id'], receiverName: json['receiverName']);
  }
}
