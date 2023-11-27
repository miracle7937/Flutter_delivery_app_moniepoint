import 'package:flutter/material.dart';

class CalculatorWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool showDropDown;
  const CalculatorWidget(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.showDropDown = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Container(
                width: 1, // Width of the vertical line
                height: 30, // Height of the vertical line
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: showDropDown
                        ? const Icon(Icons.arrow_drop_down_outlined)
                        : null,
                    hintText: hintText,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
