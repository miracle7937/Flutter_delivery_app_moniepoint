import 'package:flutter/material.dart';
import 'package:monie_point/screen/preview.dart';

import '../utils/colors.dart';
import '../widgets/btn_widget.dart';
import '../widgets/calculator_widget.dart';
import '../widgets/selectable_list.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Create a slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        title: const Text('Calculate'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                  child: Text(
                    "Destination",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: const [
                        CalculatorWidget(
                            hintText: 'Sender Location',
                            icon: Icons.domain_verification),
                        CalculatorWidget(
                            hintText: 'Receiver Location',
                            icon: Icons.domain_verification),
                        CalculatorWidget(
                            hintText: 'Approx Weight',
                            icon: Icons.hourglass_bottom),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Packaging",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "What are you sending",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: const [
                        CalculatorWidget(
                            showDropDown: true,
                            hintText: 'Box',
                            icon: Icons.domain_verification),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: SelectableList(
                    fadeAnimation: _fadeAnimation,
                    slideAnimation: _slideAnimation,
                  ),
                ),
                Center(
                  child: OrangeCircularButton(
                    text: "Calculate",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const PreviewScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
