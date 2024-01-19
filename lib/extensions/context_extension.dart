import 'dart:ui';

import 'package:flutter/material.dart';

extension UiBuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  FlutterView get view => View.of(this);

  Size get mqSize => MediaQuery.sizeOf(this);
  double get height => mqSize.height;
  double get width => mqSize.width;

  Brightness get brightness => MediaQuery.platformBrightnessOf(this);
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;

  bool get isPhone => width < 600;
  bool get isTablet => !isPhone && !isDesktop;
  bool get isMobile => isPhone || isTablet;
  bool get isDesktop => width >= 1200;
}
