import 'package:flutter/material.dart';
import 'package:real_estate_abiodun/utils/screen_size.dart';
import 'package:real_estate_abiodun/utils/theme.dart';

class SlideExpandWidget extends StatefulWidget {
  final String title;
  final bool
      isverticalContainer; // check if the container orientation is landscape
  final int animationDelayTime;

  const SlideExpandWidget(
      {super.key,
      required this.title,
      required this.isverticalContainer,
      required this.animationDelayTime});
  @override
  _SlideExpandWidgetState createState() => _SlideExpandWidgetState();
}

class _SlideExpandWidgetState extends State<SlideExpandWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    exxpand();
    // TODO: implement initState
    super.initState();
  }

  void exxpand() async {
    await Future.delayed(Duration(milliseconds: widget.animationDelayTime));
    if (mounted) {
      setState(() {
        isExpanded = !isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: isExpanded
          ? myScreenWidth(0.9, context)
          : myScreenHeight(0.06, context),
      height: myScreenHeight(0.06, context),
      decoration: BoxDecoration(
        color: isExpanded
            ? Color.fromARGB(255, 219, 209, 196)?.withOpacity(0.93)
            : null,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          widget.isverticalContainer
              ? AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  left: isExpanded
                      ? myScreenWidth(0.289, context)
                      : .0, // Slide the button
                  child: CircleAvatar(
                    radius: myScreenHeight(0.028, context),
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.orange[400],
                      size: myScreenHeight(0.02, context),
                    ),
                  ),
                )
              : AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  left: isExpanded
                      ? myScreenWidth(0.79, context)
                      : .0, // Slide the button
                  child: CircleAvatar(
                    radius: myScreenHeight(0.028, context),
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.orange[400],
                      size: myScreenHeight(0.02, context),
                    ),
                  ),
                ),
          if (!widget.isverticalContainer)
            isExpanded
                ? Center(
                    child:
                        Text(widget.title, style: _theme.textTheme.bodyMedium),
                  )
                : Container(),
          if (widget.isverticalContainer)
            isExpanded
                ? Positioned(
                    left: 10,
                    child:
                        Text(widget.title, style: _theme.textTheme.bodyMedium),
                  )
                : Container(),
        ],
      ),
    );
  }
}
