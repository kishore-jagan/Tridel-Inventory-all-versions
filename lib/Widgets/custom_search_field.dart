import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final IconData prefixIcon;
  final BorderRadius radius;

  const CustomSearchField(
      {super.key,
      this.controller,
      this.onChanged,
      this.hintText = 'Search here... eg.. Product name, model no, etc...',
      this.prefixIcon = Icons.search,
      this.radius = const BorderRadius.all(Radius.circular(20))});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 30,
        ),
        labelText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: radius,
            // borderSide: BorderSide.none
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.lightBlue),
        ),
      ),
    );
  }
}
