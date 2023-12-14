import 'dart:ui';

import 'package:flutter/material.dart';

extension UiBuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  FlutterView get view => View.of(this);
  MediaQueryData get mq => MediaQuery.of(this);

  double get height => mq.size.height;
  double get width => mq.size.width;

  bool get isDarkMode => mq.platformBrightness == Brightness.dark;
  bool get isLightMode => mq.platformBrightness == Brightness.light;

  bool get isPhone => width < 600;
  bool get isTablet => !isPhone && !isDesktop;
  bool get isMobile => isPhone || isTablet;
  bool get isDesktop => width >= 1200;
}
