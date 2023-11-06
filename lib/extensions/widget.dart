part of '/ui_extension.dart';
// import 'package:styled_widget/styled_widget.dart';

class Ui extends StatelessWidget {
  const Ui({
    super.key,
    this.child,
    this.wrapper,
  });

  final Widget Function(BuildContext context, Widget child)? wrapper;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final child = this.child ?? const SizedBox();
    return wrapper?.call(context, child) ?? child;
  }
}

extension UiExtension on Widget {
  static Curve defaultCurve = Curves.linear;

  Curve get _curve =>
      (this is ImplicitlyAnimatedWidget
              ? this as ImplicitlyAnimatedWidget
              : null)
          ?.curve ??
      defaultCurve;

  EdgeInsets _insets(
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
  ) =>
      EdgeInsets.fromLTRB(
        left ?? horizontal ?? all ?? 0.0,
        top ?? vertical ?? all ?? 0.0,
        right ?? horizontal ?? all ?? 0.0,
        bottom ?? vertical ?? all ?? 0.0,
      );

  Widget _animated(
    Duration duration,
    Curve? curve,
    VoidCallback? onEnd, {
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Clip? clipBehavior,
  }) =>
      AnimatedContainer(
        duration: duration,
        alignment: alignment,
        padding: padding,
        color: color,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        constraints: constraints,
        margin: margin,
        transform: transform,
        transformAlignment: transformAlignment,
        height: height,
        width: width,
        clipBehavior: clipBehavior ?? Clip.none,
        curve: curve ?? UiExtension.defaultCurve,
        onEnd: onEnd,
        child: this,
      );

  Widget ui({
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      Ui(
        child: this,
      );

  Widget alignment(
    // ignore: non_constant_identifier_names
    AlignmentGeometry Alignment, {
    double? heightFactor,
    double? widthFactor,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? Align(
              alignment: Alignment,
              heightFactor: heightFactor,
              widthFactor: widthFactor,
              child: this,
            )
          : AnimatedAlign(
              alignment: Alignment,
              duration: duration,
              curve: curve ?? _curve,
              onEnd: onEnd,
              heightFactor: heightFactor,
              widthFactor: widthFactor,
              child: this,
            );

  /// Adds a [Border], where [double] is the `width` of the border.
  Widget border({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    Color color = Colors.black,
    BorderStyle style = BorderStyle.solid,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) {
    final insets = _insets(all, left, top, right, bottom, horizontal, vertical);

    final decoration = BoxDecoration(
      border: Border(
        left: BorderSide(color: color, style: style, width: insets.left),
        top: BorderSide(color: color, style: style, width: insets.top),
        right: BorderSide(color: color, style: style, width: insets.right),
        bottom: BorderSide(color: color, style: style, width: insets.bottom),
      ),
    );

    return duration == null
        ? DecoratedBox(decoration: decoration, child: this)
        : _animated(duration, curve, onEnd, decoration: decoration);
  }

  Widget color(
    Color color, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? ColoredBox(color: color, child: this)
          : _animated(duration, curve, onEnd, color: color);

  Widget decoration(
    Decoration decoration, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? DecoratedBox(decoration: decoration, child: this)
          : _animated(duration, curve, onEnd, decoration: decoration);

  Widget gradient(
    Gradient gradient, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      decoration(
        BoxDecoration(gradient: gradient),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget linearGradient(
    List<Color> colors, {
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      gradient(
        LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
          tileMode: tileMode,
          transform: transform,
        ),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget constraints(
    BoxConstraints constraints, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? ConstrainedBox(constraints: constraints, child: this)
          : _animated(duration, curve, onEnd, constraints: constraints);

  Widget dimension(
    double dimension, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints.tight(Size.square(dimension)),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget height(
    double height, {
    double? width,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints.tightFor(height: height, width: width),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget width(
    double width, {
    double? height,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints.tightFor(height: height, width: width),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget size(
    Size size, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints.tight(size),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget minHeight(
    double minHeight, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints(minHeight: minHeight),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget maxHeight(
    double maxHeight, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints(maxHeight: maxHeight),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget minWidth(
    double minWidth, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints(minWidth: minWidth),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget maxWidth(
    double maxWidth, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      constraints(
        BoxConstraints(maxWidth: maxWidth),
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      );

  Widget radius({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    Clip clipBehavior = Clip.antiAlias,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? left ?? all ?? 0.0),
      topRight: Radius.circular(topRight ?? right ?? all ?? 0.0),
      bottomLeft: Radius.circular(bottomLeft ?? left ?? all ?? 0.0),
      bottomRight: Radius.circular(bottomRight ?? right ?? all ?? 0.0),
    );
    return duration == null
        ? ClipRRect(
            borderRadius: borderRadius,
            clipBehavior: clipBehavior,
            child: this,
          )
        : _animated(
            duration,
            curve,
            onEnd,
            clipBehavior: clipBehavior,
            decoration: BoxDecoration(borderRadius: borderRadius),
          );
  }

  Widget opacity(
    double opacity, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? Opacity(opacity: opacity, child: this)
          : AnimatedOpacity(
              opacity: opacity,
              duration: duration,
              curve: curve ?? _curve,
              onEnd: onEnd,
            );

  Widget flip({
    bool x = false,
    bool y = false,
    Offset? origin,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? Transform.flip(flipX: x, flipY: y, origin: origin, child: this)
          : _animated(
              duration,
              curve,
              onEnd,
              transform: Matrix4.identity()
                ..scale(x ? -1 : 1, y ? -1 : 1)
                ..translate(origin?.dx ?? 0.0, origin?.dy ?? 0.0),
            );

  Widget rotate(
    double angle, {
    Offset? origin,
    AlignmentGeometry? alignment = Alignment.center,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? Transform.rotate(
              angle: angle,
              origin: origin,
              alignment: alignment,
              child: this,
            )
          : _animated(
              duration,
              curve,
              onEnd,
              transform: Matrix4.identity()
                ..rotateZ(angle)
                ..translate(origin?.dx ?? 0.0, origin?.dy ?? 0.0),
              transformAlignment: alignment,
            );

  Widget scale(
    double scale, {
    double? x,
    double? y,
    Offset? origin,
    Alignment? aligment = Alignment.center,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? Transform.scale(
              scaleX: x ?? scale,
              scaleY: y ?? scale,
              origin: origin,
              alignment: aligment,
              child: this,
            )
          : _animated(
              duration,
              curve,
              onEnd,
              transformAlignment: aligment,
              transform: Matrix4.identity()
                ..scale(x ?? scale, y ?? scale)
                ..translate(origin?.dx ?? 0.0, origin?.dy ?? 0.0),
            );

  Widget translate({
    double? dx,
    double? dy,
    Offset? offset,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? Transform.translate(
              offset: Offset(dx ?? offset?.dx ?? 0.0, dy ?? offset?.dy ?? 0.0),
              child: this,
            )
          : _animated(
              duration,
              curve,
              onEnd,
              transform: Matrix4.identity()
                ..translate(dx ?? offset?.dx ?? 0.0, dy ?? offset?.dy ?? 0.0),
            );

  Widget padding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) {
    final insets = _insets(all, left, top, right, bottom, horizontal, vertical);
    return duration == null
        ? Padding(padding: insets, child: this)
        : AnimatedPadding(
            padding: insets,
            duration: duration,
            curve: curve ?? _curve,
            onEnd: onEnd,
            child: this,
          );
  }

  /// Fills and controls this widget position under a [Stack].
  Widget positioned({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    double? height,
    double? width,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      duration == null
          ? Positioned(
              left: left ?? horizontal ?? all,
              top: top ?? vertical ?? all,
              right: right ?? horizontal ?? all,
              bottom: bottom ?? vertical ?? all,
              height: height,
              width: width,
              child: this,
            )
          : AnimatedPositioned(
              left: left ?? horizontal ?? all,
              top: top ?? vertical ?? all,
              right: right ?? horizontal ?? all,
              bottom: bottom ?? vertical ?? all,
              height: height,
              width: width,
              duration: duration,
              curve: curve ?? _curve,
              onEnd: onEnd,
              child: this,
            );
}

extension WidgetPositioning on Widget {
  /// This child expanded in a [Row], [Column], or [Flex].
  Expanded addExpanded([int flex = 1]) => Expanded(flex: flex, child: this);

  /// This child centered with [Center].
  Center addCenter({
    double? widthFactor,
    double? heightFactor,
  }) =>
      Center(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );
}

extension WidgetListX on Iterable<Widget> {
  ///Adds [Padding] to all widgets. Order: Only > Symmetrical > All > Zero.
  // List<Widget> allPadding({
  //   double? all,
  //   double? left,
  //   double? top,
  //   double? right,
  //   double? bottom,
  //   double? horizontal,
  //   double? vertical,
  // }) {
  //   return map(
  //     (e) => e.addPadding(
  //       all: all,
  //       left: left,
  //       top: top,
  //       right: right,
  //       bottom: bottom,
  //       horizontal: horizontal,
  //       vertical: vertical,
  //     ),
  //   ).toList();
  // }

  /// Expands all the widgets inside this list.
  List<Widget> allExpanded() => map((e) => e.addExpanded()).toList();
}

extension UiListExtension<E extends Widget> on List<E> {
  List<Widget> wrap(Widget Function(E e) toWidget) {
    return map((e) => toWidget(e)).toList();
  }

  List<Widget> wrapType<T extends Widget>(Widget Function(T e) toWidget) {
    return wrap((e) => e is T ? toWidget(e) : e);
  }
}

t(List<Widget> widgets) {
  widgets.wrapType((Text e) => e.padding(all: 5));
}
