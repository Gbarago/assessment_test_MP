// import 'package:flutter/material.dart';
// import 'package:real_estate_abiodun/UI/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:real_estate_abiodun/UI/screens/home_screen.dart';
import 'package:real_estate_abiodun/UI/screens/other.dart';
import 'package:real_estate_abiodun/UI/screens/search_screen.dart'; // Import animations package

class FloatingNavBarWithTabs extends StatefulWidget {
  const FloatingNavBarWithTabs({super.key});

  @override
  _FloatingNavBarWithTabsState createState() => _FloatingNavBarWithTabsState();
}

class _FloatingNavBarWithTabsState extends State<FloatingNavBarWithTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
    _tabController.index = 2;

    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.3), // Start from bottom
      end: const Offset(0.0, 0.0), // Slide to the position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    startAnimation();
    // Start the animation
  }

  void startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: _tabController.index < _currentIndex,
            transitionBuilder: (Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              key: ValueKey<int>(_tabController.index),
              controller: _tabController,
              children: const [
                SearchScreenTab(),
                ChatScreen(),
                HomePageTab(),
                SizedBox(),
                ProfileScreen(),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.97),

            //  alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 70),
                decoration: BoxDecoration(
                  color: _theme.colorScheme.secondary.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(55),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                        icon: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _tabController.index == 0
                              ? _theme.primaryColor
                              : null),
                      child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _tabController.index != 0
                                  ? _theme.colorScheme.secondary
                                  : null),
                          child: Icon(Icons.search_sharp,
                              color: _theme.iconTheme.color)),
                    )),
                    Tab(
                        icon: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _tabController.index == 1
                              ? _theme.primaryColor
                              : null),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _tabController.index != 1
                                ? _theme.colorScheme.secondary
                                : null),
                        child: Icon(Icons.chat_bubble,
                            color: _theme.iconTheme.color),
                      ),
                    )),
                    Tab(
                      icon: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _tabController.index == 2
                                  ? _theme.primaryColor
                                  : null),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _tabController.index != 2
                                    ? _theme.colorScheme.secondary
                                    : null),
                            child:
                                Icon(Icons.home, color: _theme.iconTheme.color),
                          )),
                    ),
                    Tab(
                        icon: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _tabController.index == 3
                              ? _theme.primaryColor
                              : null),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _tabController.index != 3
                                ? _theme.colorScheme.secondary
                                : null),
                        child:
                            Icon(Icons.favorite, color: _theme.iconTheme.color),
                      ),
                    )),
                    Tab(
                        icon: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _tabController.index == 4
                              ? _theme.primaryColor
                              : null),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _tabController.index != 4
                                ? _theme.colorScheme.secondary
                                : null),
                        child:
                            Icon(Icons.person, color: _theme.iconTheme.color),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
