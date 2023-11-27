import 'package:flutter/material.dart';
import 'package:monie_point/utils/colors.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final bool enabled;
  final String? hintText;

  const CustomSearchField(
      {super.key,
      this.controller,
      this.onSubmitted,
      this.hintText,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabled: enabled,
            prefixIcon: const Icon(Icons.search, color: AppColor.mainColor),
            suffixIcon: GestureDetector(
              onTap: () {
                // Handle scan icon tap
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  // Adjust the size as needed
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  child: const Icon(
                      IconData(0xf00cc, fontFamily: 'MaterialIcons'),
                      color: Colors.white),
                ),
              ),
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
          onFieldSubmitted: onSubmitted,
          onChanged: onSubmitted,
        ),
      ),
    );
  }
}
