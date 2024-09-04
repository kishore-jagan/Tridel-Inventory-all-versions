// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'api_config.dart';

class ChartController extends GetxController {
  var categoryChart = <SalesData>[].obs;
  var data = <SalesData>[].obs;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryChart();
    fetchChartData();
  }

  Future<void> fetchCategoryChart() async {
    try {
      isLoading.value = true;

      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}${ApiConfig.stockOutChartData}'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        final Map<String, double> categoryTotals = {};

        for (var item in jsonData) {
          final category = item['category'];
          final qty = item['qty'] is int
              ? item['qty'].toDouble()
              : double.parse(item['qty']);

          if (categoryTotals.containsKey(category)) {
            categoryTotals[category] = categoryTotals[category]! + qty;
          } else {
            categoryTotals[category] = qty;
          }
        }

        categoryChart.value = categoryTotals.entries.map((entry) {
          return SalesData(
            DateTime.now(), // Dummy date
            entry.value,
            entry.key, // Category name
            '',
            entry.key, // Use category as both category and mainCategory
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching chart data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchChartData() async {
    try {
      isLoading.value = true;

      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}${ApiConfig.stockOutChartData}'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        data.value = jsonData.map((item) {
          final dateString = item['date'] as String;
          final date = DateTime.parse(dateString);
          final qty = item['qty'];
          final name = item['name'] ?? 'Unknown';
          final mainCategory = item['main_category'] ?? 'unKnown';
          final category = item['category'] ?? 'unKnown';

          return SalesData(
            date,
            qty is int ? qty.toDouble() : double.parse(qty),
            name,
            mainCategory,
            category,
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching chart data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class SalesData {
  SalesData(this.date, this.qty, this.name, this.mainCategory, this.category);

  final DateTime date;
  final double qty;
  final String name;
  final String mainCategory;
  final String category;
}
