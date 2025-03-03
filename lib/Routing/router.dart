import 'package:flutter/material.dart';
import 'package:inventory/Pages/Authentication/authentication.dart';
import 'package:inventory/Pages/BarCode/barcode.dart';
import 'package:inventory/Pages/Dispatch/dispatch.dart';
import 'package:inventory/Pages/Employee/employee.dart';
import 'package:inventory/Pages/Overview/overview.dart';
import 'package:inventory/Pages/Products/products.dart';
import 'package:inventory/Pages/Returnable/returnable.dart';
import 'package:inventory/Routing/routes.dart';

import '../Pages/Inventory/widgets/add_box.dart';
import '../Pages/Trash/trash.dart';
import '../Pages/pendingTask/pendingTask.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overViewPageRoute:
      return getPageRoute(const OverViewPage());
    case inventoryPageRoute:
      return getPageRoute(const BoxAddPage());
    case productsPageRoute:
      return getPageRoute(const ProductsPage());
    case userPageRoute:
      return getPageRoute(const EmployeePage());
    case authenticationPageRoute:
      return getPageRoute(const AuthenticationPage());
    case barcodePageroute:
      return getPageRoute(const BarCodePage());
    case dispatchPageRoute:
      return getPageRoute(const DispatchPage());
    case returnableRoute:
      return getPageRoute(ReturnableItemsPage());
    case pendingtaskRoute:
      return getPageRoute(const Pendingtask());
    case trashRoute:
      return getPageRoute(const TrashPage());

    default:
      return getPageRoute(const OverViewPage());
  }
}

PageRoute getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
