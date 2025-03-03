import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/Constants/constants.dart';
import 'package:inventory/Constants/controllers.dart';
import 'package:inventory/Constants/style.dart';
import 'package:inventory/Widgets/custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  const HorizontalMenuItem(
      {super.key, required this.itemName, required this.onTap});

  final String itemName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover('not hovering');
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName)
                ? lightGray.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    width: 6,
                    height: 40,
                    color: light,
                  ),
                ),
                SizedBox(
                  width: width / 88,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: menuController.returnIconFor(itemName),
                ),
                if (!menuController.isActive(itemName))
                  Flexible(
                      child: CustomText(
                    text: itemName,
                    color:
                        menuController.isHovering(itemName) ? light : textColor,
                  ))
                else
                  Flexible(
                      child: CustomText(
                    text: itemName,
                    color: light,
                    size: 18,
                    weight: FontWeight.bold,
                  ))
              ],
            ),
          )),
    );
  }
}
