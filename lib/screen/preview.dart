import 'package:flutter/material.dart';
import 'package:monie_point/utils/app_image.dart';
import 'package:monie_point/utils/colors.dart';

import '../main.dart';
import '../widgets/btn_widget.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<PreviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: 3986).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              const Text(
                "MoveMate",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mainColor),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(height: 130, child: Image.asset(AppImage.box)),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Total Estimated Amount",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Text(
                        "\$${_animation.value} ",
                        style:
                            const TextStyle(fontSize: 24, color: Colors.green),
                      );
                    },
                  ),
                  const Text(
                    "USD",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const Text(
                  "This amount is estimated and vary if you change your location or weight",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OrangeCircularButton(
                text: "Back to home",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const MyHomePage(
                            title: '',
                          )));
                },
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
