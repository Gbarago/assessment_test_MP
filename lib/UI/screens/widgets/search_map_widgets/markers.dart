import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';

class ListOfMarkersWidget extends StatefulWidget {
  const ListOfMarkersWidget(
      {super.key, required this.isExpanded, required this.color});

  final bool isExpanded;
  final Color color;

  @override
  State<ListOfMarkersWidget> createState() => _ListOfMarkersWidgetState();
}

class _ListOfMarkersWidgetState extends State<ListOfMarkersWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 1200.ms);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    //  _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool overlayExpanded = widget.isExpanded;
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.bottomLeft,
              child: Transform.scale(
                scale: _animation.value,
                alignment: Alignment.bottomLeft,
                child: AnimatedContainer(
                  height: 40,
                  duration: 800.ms,
                  width: !overlayExpanded ? 35 : 75,
                  padding: EdgeInsets.only(
                    left: !overlayExpanded ? 6 : 11,
                    right: !overlayExpanded ? 6 : 11,
                    //  top: !overlayExpanded ? 15 : 8
                  ),
                  decoration: BoxDecoration(
                      // color: widget.color,
                      color: context.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: !overlayExpanded
                      ? Icon(
                          Icons.apartment_rounded,
                          color: context.colorScheme.surface,
                          size: 20,
                        )
                      : Center(
                          child: AutoSizeText(
                            // [
                            //   '10,3 mn ₽',
                            //   '11 mn ₽',
                            //   '13,3 mn ₽',
                            //   '7,8 mn ₽',
                            //   '8,5 mn ₽',
                            //   '6,95 mn ₽'
                            // ][index],
                            ' 10,3 mn ₽',
                            style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                color: context.colorScheme.surface,
                                fontWeight: FontWeight.w600),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
