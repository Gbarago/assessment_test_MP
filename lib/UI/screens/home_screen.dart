import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';
import 'package:real_estate_abiodun/utils/screen_size.dart';
import 'widgets/home_widgets/home_screen_widgets.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  int _numValue1 = 0;
  int _numValue2 = 0;
  bool _expandText = false;
  bool _hideCircleRow = false;

  double _scrollPosition = 0.0;

  bool isExpanded = false;

  @override
  void initState() {
    numbersFunction();
    animateWidth();
    hideCircleWidget();
    exxpand();

    super.initState();
  }

  void exxpand() async {
    await Future.delayed(Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        isExpanded = !isExpanded;
      });
    }
  }

  void numbersFunction() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      setState(() {
        _numValue1 = 1034;
        _numValue2 = 2212;
      });
    });
  }

  void animateWidth() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        _expandText = true;
      });
    });
  }

  void hideCircleWidget() {
    Future.delayed(const Duration(milliseconds: 2600), () {
      setState(() {
        _hideCircleRow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: myScreenHeight(1, context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  _theme.primaryColor.withOpacity(0.18),
                  _theme.primaryColor.withOpacity(0.1),
                  _theme.primaryColor.withOpacity(0.02),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels is double) {
                  setState(() {
                    _scrollPosition = scrollNotification.metrics.pixels;
                  });
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10), // Space before content starts
                    Opacity(
                        opacity: (_scrollPosition <= 100)
                            ? 1.0 -
                                (_scrollPosition /
                                    100) // Adjust the opacity based on scroll
                            : 0.0,
                        child: const HomeGridWidget()),
                    const SizedBox(height: 30),

                    Offstage(
                      offstage: !_hideCircleRow,
                      child: const ImageGridwidget().slideInFromBottom(
                        delay: 2300.ms,
                        animationDuration: 1200.ms,
                        begin: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 10,
            top: 45,
            child: SizedBox(
              // color: Colors.red,
              width: size.width * 0.9,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  mainAxisSize: MainAxisSize.max,
                children: [
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.2, end: 1.0),
                      duration: Duration(milliseconds: 1300),
                      curve: Curves.easeInOut,
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: Container(
                              child: Container(
                                height: 35,
                                width: 145,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: _theme.cardColor,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: _theme.textTheme.labelSmall?.color,
                                      size: 15,
                                    ),
                                    Text(
                                      'Saints Petersburg',
                                      style:
                                          _theme.textTheme.labelSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        // color: _theme.colorScheme.secondary.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.2, end: 1.0),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeInOut,
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: Container(
                              height: 45,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: _theme.primaryColor,
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/profile_img.png'))),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
