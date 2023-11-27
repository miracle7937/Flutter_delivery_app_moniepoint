import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monie_point/utils/app_image.dart';
import 'package:monie_point/utils/colors.dart';

import '../widgets/custom_search_form.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<int>? items;
  List<int> filteredItems = [];

  @override
  void initState() {
    super.initState();

    items = List.generate(10, (index) => index);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  bool isEmpty(String? s) => s == null || s == 'null' || s.trim().isEmpty;
  void search(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      if (!isEmpty(query)) {
        items = List.generate(Random().nextInt(3) + 1, (index) => index);
        _controller.forward();
      } else {
        items = List.generate(10, (index) => index);
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 140,
            decoration: const BoxDecoration(
              color: AppColor.mainColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    )),
                Expanded(
                  child: Hero(
                    tag: "Custom_Search_Field",
                    child: Material(
                      color: Colors.transparent,
                      child: CustomSearchField(
                        onSubmitted: (v) {
                          search(v);
                        },
                        hintText: "Enter the receipt number ....",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.grey.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return ListView.builder(
                        itemCount: items?.length ?? 0,
                        itemBuilder: (context, index) {
                          // Add a delay for each item
                          final itemDelay = index * 100.0;

                          return FadeTransition(
                            opacity: _animation,
                            child: Transform.translate(
                              offset: Offset(0.0, (1 - _animation.value) * 50),
                              child: DelayedAnimation(
                                delay: itemDelay,
                                child: const SearchView(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: AppColor.mainColor, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 30,
                        child: Image.asset(
                          AppImage.packageBox,
                          color: Colors.white,
                        )),
                  )),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mac Book Pro M2",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "N1567388383839393930",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Container(
                        height: 4,
                        width: 4,
                        decoration: const BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        "Paris",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.grey,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        "Nigeria",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}

class DelayedAnimation extends StatefulWidget {
  final double delay;
  final Widget child;

  DelayedAnimation({required this.delay, required this.child});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Apply the delay to each item
    Future.delayed(Duration(milliseconds: widget.delay.toInt()), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
