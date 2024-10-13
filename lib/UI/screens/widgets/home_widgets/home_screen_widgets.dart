import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_abiodun/UI/screens/widgets/home_widgets/slide_widget.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';
import 'package:real_estate_abiodun/utils/screen_size.dart';
import 'package:real_estate_abiodun/utils/theme.dart';

class ImageGridwidget extends StatelessWidget {
  const ImageGridwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: _theme.scaffoldBackgroundColor,
          width: 10,
        ),
        color: _theme.scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 5 / 2.5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/home1.jpg',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    //  color: Colors.blue,
                  ),
                ),
                const Positioned(
                  right: 10,
                  left: 10,
                  bottom: 9,
                  child: SlideExpandWidget(
                    title: 'GladKova St, 25',
                    isverticalContainer: false,
                    animationDelayTime: 1500,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 2.5 / 5.15,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/home2.jpg',
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          const Positioned(
                              right: 10,
                              left: 10,
                              bottom: 9,
                              child: SlideExpandWidget(
                                title: 'Sedova st, 11',
                                isverticalContainer: true,
                                animationDelayTime: 2000,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 2 / 2,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/home4.jpg',
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          const Positioned(
                              right: 10,
                              left: 10,
                              bottom: 9,
                              child: SlideExpandWidget(
                                title: 'Gubina St,, 9',
                                isverticalContainer: true,
                                animationDelayTime: 1500,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AspectRatio(
                      aspectRatio: 2 / 2,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/home3.jpg',
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          const Positioned(
                              right: 10,
                              left: 10,
                              bottom: 9,
                              child: SlideExpandWidget(
                                title: 'Trefola St, 1',
                                isverticalContainer: true,
                                animationDelayTime: 2000,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HomeGridWidget extends StatefulWidget {
  const HomeGridWidget({Key? key}) : super(key: key);

  @override
  State<HomeGridWidget> createState() => _HomeGridWidgetState();
}

class _HomeGridWidgetState extends State<HomeGridWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    // Duration for the animation
    final duration = Duration(milliseconds: 1200);

    return SafeArea(
      child: SizedBox(
        // height: 1070,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Marina',
                    style: _theme.textTheme.labelMedium,
                  ),
                  SizedBox(
                    width: myScreenWidth(0.58, context),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'let\'s select your',
                        style: _theme.textTheme.titleMedium?.copyWith(
                          color: _theme.textTheme.bodyLarge?.color,
                          height: 1.1,
                          fontWeight: FontWeight.w600,
                        ),
                      ).fadeInFromBottom(
                          delay: 1000.ms, animationDuration: 450.ms),
                    ),
                  ),
                  SizedBox(
                    width: myScreenWidth(0.58, context),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'perfect place',
                        style: _theme.textTheme.titleMedium?.copyWith(
                          color: _theme.textTheme.bodyLarge?.color,
                          height: 1.1,
                          fontWeight: FontWeight.w600,
                        ),
                      ).fadeInFromBottom(
                          delay: 1100.ms, animationDuration: 400.ms),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.2, end: 1.0),
                  duration: duration,
                  curve: Curves.easeInOut,
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: Container(
                          height: myScreenWidth(0.454, context),
                          width: myScreenWidth(0.454, context),
                          decoration: BoxDecoration(
                            color: _theme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: myScreenWidth(0.04, context)),
                              Text(
                                'BUY',
                                style: _theme.textTheme.titleSmall,
                              ),
                              SizedBox(height: myScreenWidth(0.09, context)),
                              // Animated number for "1 034"
                              TweenAnimationBuilder<int>(
                                tween: IntTween(begin: 0, end: 1034),
                                duration: Duration(
                                    milliseconds:
                                        2500), // You can adjust the duration here
                                builder: (context, value, child) {
                                  return Text(
                                    '$value',
                                    style:
                                        _theme.textTheme.titleLarge?.copyWith(
                                      letterSpacing: 1.2,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'Offers',
                                style: _theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.2, end: 1.0),
                  duration: duration,
                  curve: Curves.easeInOut,
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: Container(
                          height: myScreenWidth(0.454, context),
                          width: myScreenWidth(0.454, context),
                          decoration: BoxDecoration(
                            color: _theme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: myScreenWidth(0.04, context)),
                              Text(
                                'RENT',
                                style: _theme.textTheme.titleSmall?.copyWith(
                                  color: AppTheme.goldTextColor,
                                ),
                              ),
                              SizedBox(height: myScreenWidth(0.09, context)),
                              // Animated number for "2 212"
                              TweenAnimationBuilder<int>(
                                tween: IntTween(begin: 0, end: 2212),
                                duration: Duration(
                                    milliseconds:
                                        2500), // You can adjust the duration here
                                builder: (context, value, child) {
                                  return Text(
                                    '$value',
                                    style:
                                        _theme.textTheme.titleLarge?.copyWith(
                                      color: AppTheme.goldTextColor,
                                      letterSpacing: 1.2,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'Offer',
                                style: _theme.textTheme.titleSmall?.copyWith(
                                  color: AppTheme.goldTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
