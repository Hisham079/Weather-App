import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  CustomSearchField(
      {super.key, required this.controller, required this.onPressed});
  TextEditingController? controller;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Colors.white), // Border color when the TextField is enabled
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Colors.white), // Border color when the TextField is focused
          ),
          hintStyle: const TextStyle(color: Colors.white),
          hintText: "Search for a city",
          suffixIcon: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: onPressed),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
