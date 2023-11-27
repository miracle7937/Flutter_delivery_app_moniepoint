import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monie_point/screen/search_screen.dart';

import '../utils/colors.dart';
import '../widgets/shipment_widget.dart';

class ShipmentHistory extends StatefulWidget {
  const ShipmentHistory({Key? key}) : super(key: key);

  @override
  State<ShipmentHistory> createState() => _ShipmentHistoryState();
}

class _ShipmentHistoryState extends State<ShipmentHistory>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _controller;
  late Animation<double> _animation;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
    _tabController = TabController(
      length: 5,
      vsync: this,
      animationDuration: Duration.zero,
    );
    Future.delayed(const Duration(milliseconds: 200), () {
      _tabController.animateTo(0);
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  List<Widget> tabsValue = [
    _buildTab('ALL', 5),
    _buildTab('Completed', 10),
    _buildTab('In Progress', 0),
    _buildTab('Pending Order', 0),
    _buildTab('Cancel', 0),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        title: const Text('Shipment history'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: FadeTransition(
            opacity: _animation,
            child: TabBar(
              onTap: (index) {
                _pageController.animateToPage(
                  _tabController.index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              indicatorColor: Colors.orange,
              controller: _tabController,
              isScrollable: true,
              tabs: List.generate(
                  tabsValue.length,
                  (index) => SlideFadeTransition(
                        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: Interval(index / 5, 1.0,
                                curve: Curves.easeInOut),
                          ),
                        ),
                        child: tabsValue[index],
                      )),

              //   SlideFadeTransition(
              //   child: e,
              //   animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              //     CurvedAnimation(
              //       parent: _controller,
              //       curve: Interval(index / 5, 1.0,
              //           curve: Curves.easeInOut),
              //     ),
              //   ),
              // )
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
              child: Text(
                "Available Vehicles",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: PageView(
              pageSnapping: false, // Disable snapping for a smoother animation
              scrollDirection: Axis.vertical,
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {},
              children: [
                _veiw(_animation, 10),
                _veiw(_animation, 1),
                _veiw(_animation, 2),
                _veiw(_animation, 5),
                _veiw(_animation, 6),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

_veiw(Animation<double> animation, int count) {
  return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ListView.builder(
            itemCount: count,
            itemBuilder: (c, i) {
              final itemDelay = i * 100.0;

              return FadeTransition(
                  opacity: animation,
                  child: Transform.translate(
                      offset: Offset(0.0, (1 - animation.value) * 50),
                      child: DelayedAnimation(
                          delay: itemDelay, child: const ShipmentWidget())));
            });
      });
}

Tab _buildTab(String text, int notificationCount) {
  return Tab(
    child: Row(
      children: [
        Text(text),
        const SizedBox(
          width: 3,
        ),
        notificationCount > 0
            ? Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  notificationCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : Container(),
      ],
    ),
  );
}

class SlideFadeTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const SlideFadeTransition(
      {super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset((1.0 - animation.value) * 100.0, 0.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
