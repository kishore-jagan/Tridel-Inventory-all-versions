import 'package:flutter/material.dart';

import '../../../Constants/constants.dart';
import 'chart_area.dart';

class ChartTotalPortfolio extends StatelessWidget {
  const ChartTotalPortfolio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: defaultPadding),
          padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 2, vertical: defaultPadding * 1.5),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 238, 250, 255),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Chart",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  BtnContainer(
                    text: "1m",
                    colorText: secondaryColor,
                    colorBackground: Colors.white,
                  ),
                  BtnContainer(
                    text: "3m",
                    colorText: secondaryColor,
                    colorBackground: Colors.white,
                  ),
                  BtnContainer(
                    text: "6m",
                    colorText: Colors.white,
                    colorBackground: secondaryColor,
                  ),
                  BtnContainer(
                    text: "9m",
                    colorText: secondaryColor,
                    colorBackground: Colors.white,
                  ),
                  // Text(
                  //   "Monthly",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodySmall
                  //       ?.copyWith(color: textColor, fontSize: 10),
                  // ),
                  Icon(
                    Icons.expand_more,
                    color: secondaryColor,
                  )
                ],
              ),
              SizedBox(height: defaultPadding),
              ChartArea(),
            ],
          ),
        ),
        Positioned.fill(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: secondaryColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: secondaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: secondaryColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.arrow_forward_ios,
                color: secondaryColor,
              ),
            )
          ],
        ))
      ],
    );
  }
}

class BtnContainer extends StatelessWidget {
  const BtnContainer({
    super.key,
    required this.text,
    required this.colorText,
    required this.colorBackground,
  });

  final String text;
  final Color colorText;
  final Color colorBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 4),
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          color: colorBackground,
          border: Border.all(color: secondaryColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorText, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
