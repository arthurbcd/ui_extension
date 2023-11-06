part of '../ui_extension.dart';

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

  /// Visits the first [T] element found.
  T? visitElement<T extends Element>({
    bool last = false,
    bool Function(T element)? filter,
  }) =>
      (this as Element).visitElement<T>(last: last, filter: filter);

  /// Visits the first [T] widget found.
  T? visitWidget<T extends Widget>({
    bool last = false,
    bool Function(T widget)? filter,
  }) =>
      (this as Element).visitWidget<T>(last: last, filter: filter);

  /// Visits the first [T] state found.
  T? visitState<T extends State>({
    bool last = false,
    bool Function(T state)? filter,
  }) =>
      (this as Element).visitState<T>(last: last, filter: filter);
}
