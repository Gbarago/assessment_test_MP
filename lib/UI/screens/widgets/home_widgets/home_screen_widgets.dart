import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';
import 'package:real_estate_abiodun/utils/screen_size.dart';
import 'package:real_estate_abiodun/utils/theme.dart';
import 'package:intl/intl.dart';

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

    if (mounted) {
      _slideAnimation = Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset(0.0, 0.0),
      ).animate(_animationController);
      _animationController.forward();
    }
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
    const duration = Duration(milliseconds: 1200);

    return SafeArea(
      child: SizedBox(
        // height: 1070,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            HomeHeaderTextWidget(theme: _theme),
            const SizedBox(height: 50),
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
                              TweenAnimationBuilder<int>(
                                tween: IntTween(begin: 0, end: 1034),
                                duration: const Duration(milliseconds: 1800),
                                builder: (context, value, child) {
                                  final formattedValue =
                                      NumberFormat("#,##0", "en_US")
                                          .format(value)
                                          .replaceAll(",", " ");

                                  return Text(
                                    '$formattedValue',
                                    style:
                                        _theme.textTheme.titleLarge?.copyWith(
                                      letterSpacing: 0.5,
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
                              SizedBox(
                                height: myScreenWidth(0.09, context),
                              ),
                              TweenAnimationBuilder<int>(
                                tween: IntTween(begin: 0, end: 2212),
                                duration: const Duration(milliseconds: 1800),
                                builder: (context, value, child) {
                                  final formattedValue =
                                      NumberFormat("#,##0", "en_US")
                                          .format(value)
                                          .replaceAll(",", " ");
                                  return Text(
                                    '$formattedValue',
                                    style:
                                        _theme.textTheme.titleLarge?.copyWith(
                                      color: AppTheme.goldTextColor,
                                      letterSpacing: 0.5,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'Offers',
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

class HomeHeaderTextWidget extends StatelessWidget {
  const HomeHeaderTextWidget({
    super.key,
    required ThemeData theme,
  }) : _theme = theme;

  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, Marina',
            style: _theme.textTheme.bodyLarge,
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
              ).fadeInFromBottom(delay: 1000.ms, animationDuration: 450.ms),
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
              ).fadeInFromBottom(delay: 1100.ms, animationDuration: 400.ms),
            ),
          ),
        ],
      ),
    );
  }
}
