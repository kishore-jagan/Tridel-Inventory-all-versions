// ignore_for_file: file_names

import 'package:get/get.dart';

import '../model/trashModel.dart';
import 'trash_service.dart';

class TrashController extends GetxController {
  var trash = <Trash>[].obs;

  Future<void> fetchBin() async {
    var response = await TrashService().getBin();

    if (response != null && response is List<Trash>) {
      trash.assignAll(response);
    } else {
      trash.assignAll([]);
    }
  }
}
