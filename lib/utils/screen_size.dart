import 'package:flutter/material.dart';

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

double myScreenWidth(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.width;
}

double myScreenHeight(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height;
}
