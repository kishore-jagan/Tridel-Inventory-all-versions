import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:inventory/api_services/api_config.dart';

import '../model/box_model.dart';

class BoxService {
  Future<List<BoxModel>?> fetchBox() async {
    var response =
        await http.get(Uri.parse("${ApiConfig.baseUrl}${ApiConfig.getBox}"));
    // print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var boxes = data['data'];
      List<BoxModel> boxList =
          (boxes as List).map((e) => BoxModel.fromJson(e)).toList();
      // print("boxxxx: $boxList");
      return boxList;
    } else {
      // ignore: avoid_print
      print("Failed to fetch boxes with status code: ${response.statusCode}");
      return null;
    }
  }
}
