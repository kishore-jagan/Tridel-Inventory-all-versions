class ApiConfig {
  static const String baseUrl = 'http://192.168.0.101';
  static const String auth = '/Inventory_Api/auth.php';
  static const String stockCount = '/Inventory_Api/total_productcount.php';
  static const String vendorCount = '/Inventory_Api/vendor_count.php';
  static const String employeeCount = '/Inventory_Api/employee_count.php';
  // static const String stockInChartData = '/Inventory_Api/stockinChart_data.php';
  static const String stockOutChartData =
      '/Inventory_Api/stockoutChart_data.php';
  static const String stockOutRevenue = '/Inventory_Api/stockout_revenue.php';
  static const String addInventory = '/Inventory_Api/add_inventory.php';
  static const String fetchVendor = '/Inventory_Api/fetch_vendor.php';
  static const String fetchReceiver = '/Inventory_Api/fetch_receiver.php';
  static const String addVendor = '/Inventory_Api/add_vendor.php';
  static const String addReceiver = '/Inventory_Api/add_receiver.php';
  static const String fetchProducts = '/Inventory_Api/fetch_products.php';
  static const String updateProduct = '/Inventory_Api/update_product.php';
  static const String deleteProduct = '/Inventory_Api/delete_product.php';
  static const String getBin = '/Inventory_Api/get_bin.php';
  static const String undo = '/Inventory_Api/undo.php';
  static const String returnable = '/Inventory_Api/returnable_status.php';
  static const String addEmployee = '/Inventory_Api/add_employee.php';
  static const String employeeList = '/Inventory_Api/fetch_employees.php';
  static const String dispatchItems = '/Inventory_Api/dispatch.php';
  static const String fetchDispatch =
      '/Inventory_Api/get_dispatched_products.php';
  static const String saveBox = '/Inventory_Api/save_box.php';
  static const String getBox = '/Inventory_Api/get_box.php';
  static const String boxUpdate = '/Inventory_Api/update_box.php';
}
