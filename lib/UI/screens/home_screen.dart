import 'package:flutter/material.dart';
import 'widgets/home_widgets/home_screen_widgets.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   leading: Container(
      //     width: 80,
      //     decoration: BoxDecoration(color: _theme.scaffoldBackgroundColor),
      //   ),
      // ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  _theme.primaryColor.withOpacity(0.18),
                  _theme.primaryColor.withOpacity(0.1),
                  _theme.primaryColor.withOpacity(0.02),

                  //_theme.scaffoldBackgroundColor,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: const SingleChildScrollView(
              child: HomeGridWidget(),
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
