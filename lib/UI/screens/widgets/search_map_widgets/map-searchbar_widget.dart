import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_abiodun/utils/estensions.dart';
import 'package:real_estate_abiodun/utils/image_paths.dart';
import 'package:svg_flutter/svg_flutter.dart';

class MapSearchBarWidget extends StatelessWidget {
  const MapSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: TextFormField(
                      controller:
                          TextEditingController(text: 'Saint Petersburg'),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        fillColor: context.colorScheme.surface,
                        filled: true,
                        prefixIcon: SvgPicture.asset(
                          ImagesPaths.search2,
                        ).padOnly(left: 5),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 45,
                          minHeight: 30,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ).scale(animationDuration: 1200.ms, delay: 200.ms),
                ),
                SizedBox(width: 12),
                CircleAvatar(
                  backgroundColor: context.colorScheme.surface,
                  foregroundColor: context.colorScheme.onSurface,
                  child: SvgPicture.asset(
                    ImagesPaths.filter,
                    height: 18,
                  ),
                ).scale(animationDuration: 1210.ms, delay: 200.ms),
              ].rowInPadding(1),
            ),
          ),
        ));
  }
}
