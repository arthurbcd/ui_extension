part of '../ui_extension.dart';

build(BuildContext context) {
  final a = context.responsiveValue(
    desktop: 100,
    tablet: 50,
    mobile: 25,
  );
}

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

class ValueBuilder<T> extends StatefulWidget {
  const ValueBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.onInit,
    this.onReady,
    this.onUpdate,
    this.onDispose,
  });

  final T value;
  final Widget Function(T value, ValueSetter<T> setValue) builder;
  final ValueSetter<T>? onInit;
  final void Function(T value, ValueSetter<T> setValue)? onReady;
  final void Function(T value)? onUpdate;
  final ValueSetter<T>? onDispose;

  @override
  State<ValueBuilder> createState() => _ValueBuilderState<T>();
}

class _ValueBuilderState<T> extends State<ValueBuilder<T>> {
  late T value = widget.value;
  void setter(T value) {
    widget.onUpdate?.call(value);
    setState(() => this.value = value);
  }

  @override
  void initState() {
    widget.onInit?.call(value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onReady?.call(value, setter);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(value, setter);
  }

  @override
  void dispose() {
    widget.onDispose?.call(value);
    super.dispose();
  }
}
