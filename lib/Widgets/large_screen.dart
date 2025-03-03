import 'package:flutter/material.dart';
import 'package:inventory/Helpers/local_navigator.dart';
import 'package:inventory/Widgets/side_menu.dart';

import '../Constants/constants.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding * 1.5),
      child: Row(
        children: [
          const Expanded(
            child: SideMenu(),
          ),
          Expanded(
              flex: 5,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: localNavigator()))
        ],
      ),
    );
  }
}
