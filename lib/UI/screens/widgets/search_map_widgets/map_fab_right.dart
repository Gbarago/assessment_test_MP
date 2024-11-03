import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';
import 'package:real_estate_abiodun/utils/theme.dart';

class ExtendedRightFabBTN extends StatelessWidget {
  const ExtendedRightFabBTN({super.key});

  @override
  Widget build(BuildContext context) {
    //  final _theme = Theme.of(context);

    return Positioned(
      bottom: context.sizeHeight(0.11),
      right: 20,
      child: Card(
        elevation: 0,
        shape: const StadiumBorder(),
        color: AppTheme.tertiary,
        child: Row(
                children: [
          Icon(
            Icons.sort_rounded,
            color: context.colorScheme.surface.withOpacity(0.7),
            size: 18,
          ),
          Text(
            'List of variants',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surface.withOpacity(0.7),
            ),
          ),
        ].rowInPadding(5))
            .padAll(15),
      ).scale(animationDuration: 1400.ms, delay: 200.ms),
    );
  }
}
