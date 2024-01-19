import 'dart:ui';

import 'package:flutter/material.dart';

extension UiBuildContextExtension on BuildContext {

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

extension ContextExt on BuildContext {
  ///Ensure the context widget is entirely visible. Defaults to scroll center.
  Future<void> ensureVisible({
    Duration duration = const Duration(milliseconds: 600),
    double aligment = 0.5,
  }) =>
      Scrollable.ensureVisible(this, alignment: 0.5, duration: duration);

  ///Current theme of the app.
  ThemeData get theme => Theme.of(this);

  ///Current view of the app.
  FlutterView get view => View.of(this);

  ///The colors scheme of the current theme.
  ColorScheme get colors => Theme.of(this).colorScheme;

  ///The text styles of the current theme.
  TextTheme get texts => theme.textTheme;

  ///If the [ThemeMode] is dark.
  bool get isDarkMode => colors.brightness == Brightness.dark;

  ///Visits all [T] widgets below this context. If [T] is absent, visits all.
  ///
  ///Additionally returns a list of the Widgets found.
  ///
  ///You can rebuild the widgets found. Native and private classes are ignored,
  ///making this very lightweight and fast.
  List<T> visitAll<T extends Widget>({
    bool rebuild = false,
    void Function(Widget parent, T widget)? onWidget,
    void Function(Element parent, Element element)? onElement,
  }) {
    final list = <T>[];
    var parent = this as Element;

    bool ignoreType(Widget widget) {
      if (widget.runtimeType.toString().startsWith('_')) return true;
      if (widget.runtimeType.toString().startsWith('Cupertino')) return true;
      return false;
    }

    void visit(Element element) {
      if (element.widget is T) {
        onElement?.call(parent, element);
        onWidget?.call(parent.widget, element.widget as T);

        if (!rebuild) list.add(element.widget as T);

        if (rebuild && !ignoreType(element.widget)) {
          list.add(element.widget as T);
          element.markNeedsBuild();
        }
      }
      parent = element;
      element.visitChildren(visit);
    }

    parent.visitChildren(visit);
    return list;
  }

  /// Visits the first [T] found and returns its [Element].
  ///
  /// If [last] is true, then it will return the last [Element] found.
  /// Visiting last is O(N), avoid using [last] = true.
  ///
  Element? visit<T extends Widget>({
    bool last = false,
    bool Function(T widget)? filter,
  }) {
    Element? found;

    void visit(Element element) {
      if (element.widget is T && (filter?.call(element.widget as T) ?? true)) {
        found = element;
        if (!last) return;
      }
      element.visitChildren(visit);
    }

    (this as Element).visitChildren(visit);
    return found;
  }
}

extension FlutterViewExtension on FlutterView {
  ///The [Size] of this device in logical pixels.
  Size get size => physicalSize / devicePixelRatio;

  ///The horizontal extent of this size.
  double get width => size.width;

  ///The vertical extent of this size
  double get height => size.height;
}

extension PageViewExtension on BuildContext {
  PageView get _view {
    final page = findAncestorWidgetOfExactType<PageView>();
    assert(page != null, 'No PageView found above this context');
    return page!;
  }

  /// The [PageController] of the parent [PageView].
  PageController get pageController => _view.controller;

  /// Whether the parent [PageView] is at the last page.
  bool get isLastPage {
    if (_view.childrenDelegate.estimatedChildCount == null) return false;
    final totalPages = _view.childrenDelegate.estimatedChildCount! - 1;
    return totalPages == _view.controller.page?.round();
  }

  /// Animates the parent [PageView] from the current page to the given page.
  Future<void> toPage(
    int page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async =>
      pageController.animateToPage(page, duration: duration, curve: curve);

  /// Animates the parent [PageView] to the next page.
  Future<void> nextPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async =>
      pageController.nextPage(duration: duration, curve: curve);

  /// Animates the parent [PageView] to the previous page.
  Future<void> previousPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async =>
      pageController.previousPage(duration: duration, curve: curve);
}

extension TabViewExtension on BuildContext {
  TabController get tabController => DefaultTabController.of(this);

  /// Whether the parent `TabView` is at the last tab.
  bool get isLastTab => tabController.length == tabController.index + 1;

  /// Whether the parent `TabView` is at the first tab.
  bool get isFirstTab => tabController.index == 0;

  void toTab(
    int index, {
    Duration? duration,
    Curve curve = Curves.ease,
  }) {
    tabController.animateTo(index, duration: duration, curve: curve);
  }
}

extension ColorSchemeExtension on ColorScheme {
  ///Tells if the current theme in this is dark.
  bool get isDark => brightness == Brightness.dark;

  ///Flutter official guideline for disabled color.
  Color get disabled => onSurface.withOpacity(0.38);

  ///The default flutter textTheme. This will override your theme. Use as ref.
  TextTheme get defaultText =>
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;
}

extension SetMaterialStateExtension on Set<MaterialState> {
  bool get isHovered => contains(MaterialState.hovered);
  bool get isFocused => contains(MaterialState.focused);
  bool get isPressed => contains(MaterialState.pressed);
  bool get isDragged => contains(MaterialState.dragged);
  bool get isSelected => contains(MaterialState.selected);
  bool get isScrolledUnder => contains(MaterialState.scrolledUnder);
  bool get isDisabled => contains(MaterialState.disabled);
  bool get isError => contains(MaterialState.error);
}

extension MaterialColorGenerator on Color {
  ///Add shades to this [Color].
  ///
  /// From Lighest to Darkest. Where [500] is the same color.
  /// - [50],[100],[200],[300],[400],[500],[600],[700],[800],[900].
  ///
  /// Any other value will return the closest shade value.
  Color operator [](int shade) {
    final shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

    if (shades.contains(shade)) return swatch[shade]!;
    if (shade < 25) return Colors.white;
    if (shade < 75) return swatch[50]!;
    if (shade >= 950) return Colors.black;
    if (shade >= 850) return swatch[900]!;

    ///Round to closest shade.
    return swatch[(shade / 100).round() * 100]!;
  }

  /// Generates [MaterialColor] swatch from a single Color.
  MaterialColor get swatch {
    return _createMaterialColor(this);
  }

  MaterialColor _createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red;
    final g = color.green;
    final b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  ///Set this [Color] as default and add optional states.
  ///
  ///Attention, this will be applied for all states!
  ///It's really recommended to set some invidiual states.
  MaterialStateProperty<Color?> resolve({
    Color? hovered,
    Color? focused,
    Color? pressed,
    Color? dragged,
    Color? selected,
    Color? scrolledUnder,
    Color? disabled,
    Color? error,
  }) {
    return MaterialStateColor.resolveWith((states) {
      if (states.isHovered && hovered != null) return hovered;
      if (states.isFocused && focused != null) return focused;
      if (states.isPressed && pressed != null) return pressed;
      if (states.isDragged && dragged != null) return dragged;
      if (states.isSelected && selected != null) return selected;
      if (states.isScrolledUnder && scrolledUnder != null) return scrolledUnder;
      if (states.isDisabled && disabled != null) return disabled;
      if (states.isError && error != null) return error;
      return this;
    });
  }
}
