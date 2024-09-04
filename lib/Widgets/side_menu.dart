import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/Constants/controllers.dart';
import 'package:inventory/Constants/style.dart';
import 'package:inventory/Helpers/responsiveness.dart';
import 'package:inventory/Routing/routes.dart';
import 'package:inventory/Widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: ResponsiveWidget.isSmallScreen(context)
              ? BorderRadius.all(Radius.circular(8))
              : BorderRadius.all(Radius.circular(30))),
      child: ListView(
        children: [
          ResponsiveWidget.isLargeScreen(context)
              ? SizedBox(
                  height: 90,
                  child: DrawerHeader(
                      padding: EdgeInsets.only(left: defaultPadding * 1.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/image/inventory2.png",
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Admin Panel",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: light,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                            ],
                          ),
                          Text(
                            "Main Menu",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white70, fontSize: 10),
                          )
                        ],
                      )),
                )
              : SizedBox(
                  height: 120,
                  child: DrawerHeader(
                      padding: EdgeInsets.only(left: defaultPadding * 1.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/image/inventory2.png",
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Admin Panel",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: light,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                          ),
                          Text(
                            "Main Menu",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white70, fontSize: 10),
                          )
                        ],
                      )),
                ),
          SizedBox(height: defaultPadding),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        if (item.route == authenticationPageRoute) {
                          menuController
                              .changeActiveItemTo(overViewPageDisplayName);
                          Get.offAllNamed(authenticationPageRoute);
                        }

                        if (!menuController.isActive(item.name)) {
                          menuController.changeActiveItemTo(item.name);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo(item.route);
                        }
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
