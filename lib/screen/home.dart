import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monie_point/screen/search_screen.dart';
import 'package:monie_point/screen/shipment_history.dart';

import '../utils/app_image.dart';
import '../utils/colors.dart';
import '../widgets/available_vehicle.dart';
import '../widgets/custom_search_form.dart';
import '../widgets/tracking_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Top
      end: Offset.zero, // Center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  List<Widget> shippingItem = const [
    AvailableVehicle(
      title: "Ocean freight",
      subtitle: "International",
      image: AppImage.cargoShip,
    ),
    AvailableVehicle(
      title: "Cargo freight",
      subtitle: "Reliable",
      image: AppImage.cargoTruck,
    ),
    AvailableVehicle(
      title: "Ocean freight",
      subtitle: "International",
      image: AppImage.cargoShip,
    )
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(155), // Set this height
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              color: AppColor.mainColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22.0,
                          backgroundColor: AppColor.mainColor,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500',
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.location_fill,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Your location",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Wertheimer, Illinois",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 22.0,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SearchScreen()));
                      },
                      child: const Hero(
                        tag: "Custom_Search_Field",
                        child: Material(
                          color: Colors.transparent,
                          child: CustomSearchField(
                            enabled: false,
                            hintText: "Enter the receipt number ....",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: Container(
        color: Colors.grey.withOpacity(0.08),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Tracking",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const TrackingWidget(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Available Vehicles",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            shippingItem.length,
                            (index) => SlideFadeTransition(
                                  animation: Tween<double>(begin: 0.0, end: 1.0)
                                      .animate(
                                    CurvedAnimation(
                                      parent: _controller,
                                      curve: Interval(index / 5, 1.0,
                                          curve: Curves.easeInOut),
                                    ),
                                  ),
                                  child: shippingItem[index],
                                )),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
