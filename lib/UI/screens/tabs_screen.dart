import 'package:flutter/material.dart';
import 'package:real_estate_abiodun/UI/screens/home_screen.dart';
import 'package:real_estate_abiodun/UI/screens/other.dart';
import 'package:real_estate_abiodun/UI/screens/search_screen.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';

import 'widgets/animations/inkresponse.dart';

class FloatingNavBarWithTabs extends StatefulWidget {
  const FloatingNavBarWithTabs({Key? key}) : super(key: key);

  @override
  _FloatingNavBarWithTabsState createState() => _FloatingNavBarWithTabsState();
}

class _FloatingNavBarWithTabsState extends State<FloatingNavBarWithTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  late AnimationController _navBarAnimationController;
  late AnimationController _rippleAnimationController;

  late Animation<Offset> _navBarSlideAnimation;
  late Animation<double> _rippleAnimation;
  bool _onHideBorder = false;
  late double _begin, _end;
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

    // Animation Controller for the Nav Bar sliding from bottom
    _navBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600), // Duration for the slide
      vsync: this,
    );

    // Slide from bottom to its position
    _navBarSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 2), // Start from below the screen
      end: const Offset(0, 0), // End at normal position
    ).animate(CurvedAnimation(
      parent: _navBarAnimationController,
      curve: Curves.easeInOut,
    ));

    _startNavBarSlideAnimation(); // Start the nav bar sliding in

    _begin = 30;
    _end = 20;
    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _rippleAnimation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(
      CurvedAnimation(
        parent: _rippleAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _rippleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hideBorder();
        _rippleAnimationController.reset();
      }
    });
  }

  void _hideBorder() {
    setState(() {
      _onHideBorder = false;
    });
  }

  void _startNavBarSlideAnimation() async {
    await Future.delayed(Duration(seconds: 4));
    _navBarAnimationController.forward(from: 0.0); // Start the animation
  }

  void _onDisplayBorder() {
    setState(() {
      _onHideBorder = true;
    });
  }

  void _onTap() {
    _onDisplayBorder();
    _rippleAnimationController.forward();
  }

  @override
  void dispose() {
    _rippleAnimationController.dispose();
    _tabController.dispose();
    _navBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Tab content with no slide (just fade or no animation)
          TabBarView(
            physics: const NeverScrollableScrollPhysics(), // Disable swipe
            key: ValueKey<int>(_tabController.index),
            controller: _tabController,
            children: [
              SearchScreenTab(),
              ChatScreen(),
              HomePageTab(),
              SizedBox(),
              ProfileScreen(),
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.97),
            child: SlideTransition(
              position:
                  _navBarSlideAnimation, // Apply slide animation to nav bar
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
                    _buildTab(
                      icon: Icons.search_sharp,
                      index: 0,
                      theme: _theme,
                    ),
                    _buildTab(
                      icon: Icons.chat_bubble,
                      index: 1,
                      theme: _theme,
                    ),
                    _buildTab(
                      icon: Icons.home,
                      index: 2,
                      theme: _theme,
                    ),
                    _buildTab(
                      icon: Icons.favorite,
                      index: 3,
                      theme: _theme,
                    ),
                    _buildTab(
                      icon: Icons.person,
                      index: 4,
                      theme: _theme,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildTab({
//     required IconData icon,
//     required int index,
//     required ThemeData theme,
//   }) {
//     return Tab(
//       icon: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           splashColor: theme.primaryColor.withOpacity(0.4),
//           highlightColor: theme.primaryColor.withOpacity(0.2),
//           onTap: () {
//             setState(() {
//               _tabController.index = index;
//             });
//           },
//           child: Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _tabController.index == index ? theme.primaryColor : null,
//             ),
//             child: Center(
//               child: Container(
//                 width: 25,
//                 height: 25,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _tabController.index != index
//                       ? theme.colorScheme.secondary
//                       : null,
//                 ),
//                 child: Icon(icon, color: theme.iconTheme.color),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

  Widget _buildTab({
    required IconData icon,
    required int index,
    required ThemeData theme,
  }) {
    return Tab(
      icon: Material(
        color: Colors.transparent, // Transparent background for ripple effect
        child:
            //
            // InkWell(
            //   borderRadius:
            //       BorderRadius.circular(20), // Rounded border for ripple effect
            //   splashColor:
            //       theme.primaryColor.withOpacity(0.4), // Ripple color when pressed
            //   highlightColor:
            //       theme.primaryColor.withOpacity(0.2), // Highlight color for press
            //   onTap: () {
            //     setState(() {
            //       _tabController.index = index; // Update tab index on tap
            //     });
            //   },
            //   child: Container(
            //     width: 38,
            //     height: 38,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: _tabController.index == index
            //           ? theme.primaryColor
            //           : null, // Highlight selected tab
            //     ),
            //     child: Center(
            //       child: Container(
            //         width: 25,
            //         height: 25,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: _tabController.index != index
            //               ? theme.colorScheme.secondary
            //               : null,
            //         ),

            InkResponseWidget(
          index: index,
          onTap: () {
            setState(() {
              _tabController.index = index; // Update tab index on tap
            });

            _onTap();
          },
          rippleAnimation: _rippleAnimation,
          width: _tabController.index == index ? 55 : 47,
          height: _tabController.index == index ? 55 : 47,
          showRipple: _tabController.index == index,
          onHideBorder: _onHideBorder,
          decoration: BoxDecoration(
            color: _tabController.index == index && !_onHideBorder
                ? theme.primaryColor
                : _tabController.index == 0
                    ? Colors.black26
                    : null,
            //context.colorScheme.onSurface,
            shape: BoxShape.circle,
            border: _onHideBorder && _tabController.index == index
                ? Border.all(color: context.colorScheme.surface, width: 1)
                : null,
          ),

          child: Icon(icon, color: theme.iconTheme.color),

          ///   ),
          //  ),
          // ),
        ),
      ),
    );
  }
}
