part of '/ui_extension.dart';

extension UiPositionExtension on Ui {
  /// Adds a child to this widget.
  Ui addChild(SingleChildWidget child) {
    return Ui(key: key, children: children + [child], child: this.child);
  }

  /// Adds children to this widget.
  Ui addChildren(List<SingleChildWidget> children) {
    return Ui(key: key, children: this.children + children, child: child);
  }

  /// Adds an [Align], or [AnimatedAlign] if [duration] is present.
  ///
  /// See [UiAlign] for more details.
  Ui align(
    // ignore: non_constant_identifier_names
    AlignmentGeometry Alignment, {
    double? heightFactor,
    double? widthFactor,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiAlign(
        alignment: Alignment,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
      ));

  /// Adds a [Padding], or [AnimatedPadding] if [duration] is present.
  ///
  /// See [UiPadding] for more details.
  Ui padding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    EdgeInsetsGeometry? padding,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) {
    return addChild(UiPadding(
      all: all,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      horizontal: horizontal,
      vertical: vertical,
      padding: padding,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
    ));
  }

  /// Adds a [Positioned], or [AnimatedPositioned] if [duration] is present.
  ///
  /// See [UiPositioned] for more details.
  Ui positioned({
    bool fill = false,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) {
    if (fill) {
      left ??= 0;
      top ??= 0;
      right ??= 0;
      bottom ??= 0;
    }
    return addChild(UiPositioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      height: height,
      width: width,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
    ));
  }

  /// Adds a [Flexible] or [AnimatedFlexible] if [duration] is present.
  ///
  /// See [UiFlexible] for more details.
  Ui flexible({
    int flex = 1,
    FlexFit fit = FlexFit.loose,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiFlexible(
        fit: fit,
        flex: flex,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds an [Expanded] or [AnimatedExpanded] if [duration] is present.
  ///
  /// See [UiExpanded] for more details.
  Ui expanded({
    int flex = 1,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiExpanded(
        flex: flex,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds a [ConstrainedBox], or [AnimatedConstrainedBox] if [duration] is present.
  ///
  /// See [UiConstrainedBox] for more details.
  Ui constrained(
    BoxConstraints constraints, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiConstrainedBox(
        constraints: constraints,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
        child: this,
      ));

  /// Adds a [SizedBox], or [AnimatedSizedBox] if [duration] is present.
  ///
  /// See [UiSizedBox] for more details.
  Ui sized({
    Size? size,
    double? width,
    double? height,
    double? dimension,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiSizedBox(
        width: width ?? size?.width ?? dimension,
        height: height ?? size?.height ?? dimension,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds a [DecoratedBox], or [AnimatedDecoratedBox] if [duration] is present.
  ///
  /// See [UiDecoratedBox] for more details.
  Ui decorated(
    Decoration decoration, {
    DecorationPosition position = DecorationPosition.background,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiDecoratedBox(
        decoration: decoration,
        position: position,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds a [Opacity], or [AnimatedOpacity] if [duration] is present.
  ///
  /// See [UiOpacity] for more details.
  Ui opacity(
    double opacity, {
    bool alwaysIncludeSemantics = false,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiOpacity(
        opacity: opacity,
        alwaysIncludeSemantics: alwaysIncludeSemantics,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds a [ClipRRect], or [AnimatedClipRRect] if [duration] is present.
  ///
  /// See [UiClipRRect] for more details.
  Ui colored(
    Color color, {
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiColoredBox(
        color: color,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds a [PhysicalModel], or [AnimatedPhysicalModel] if [duration] is present.
  ///
  /// See [UiPhysicalModel] for more details.
  Ui physical({
    double elevation = 0.0,
    Color color = Colors.transparent,
    Color shadowColor = const Color(0xFF000000),
    Clip clipBehavior = Clip.none,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius borderRadius = BorderRadius.zero,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiPhysicalModel(
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        clipBehavior: clipBehavior,
        shape: shape,
        borderRadius: borderRadius,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));
}

// extension UiConstraintsExtension on Widget {

// extension UiDecorationExtension on Widget {
//   Widget border({
//     BorderSide? all,
//     BorderSide? left,
//     BorderSide? top,
//     BorderSide? right,
//     BorderSide? bottom,
//     BorderSide? horizontal,
//     BorderSide? vertical,
//     BorderRadiusGeometry? borderRadius,
//     DecorationPosition position = DecorationPosition.background,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) {
//     return decoration(
//       BoxDecoration(
//         borderRadius: borderRadius,
//         border: Border(
//           left: left ?? horizontal ?? all ?? BorderSide.none,
//           top: top ?? vertical ?? all ?? BorderSide.none,
//           right: right ?? horizontal ?? all ?? BorderSide.none,
//           bottom: bottom ?? vertical ?? all ?? BorderSide.none,
//         ),
//       ),
//       position: position,
//       duration: duration,
//       curve: curve,
//       onEnd: onEnd,
//     );
//   }

//   Widget borderWidth({
//     double? all,
//     double? left,
//     double? top,
//     double? right,
//     double? bottom,
//     double? horizontal,
//     double? vertical,
//     double? radius,
//     double? radiusX,
//     double? radiusY,
//     Color color = Colors.black,
//     BorderStyle style = BorderStyle.solid,
//     double strokeAlign = BorderSide.strokeAlignInside,
//     DecorationPosition position = DecorationPosition.foreground,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) {
//     final r = Radius.elliptical(radiusX ?? radius ?? 0, radiusY ?? radius ?? 0);
//     final lWidth = left ?? horizontal ?? all;
//     final tWidth = top ?? vertical ?? all;
//     final rWidth = right ?? horizontal ?? all;
//     final bWidth = bottom ?? vertical ?? all;
//     final side = BorderSide(
//       color: color,
//       style: style,
//       strokeAlign: strokeAlign,
//       width: 0,
//     );

//     return border(
//       left: lWidth != null ? side.copyWith(width: lWidth) : null,
//       top: tWidth != null ? side.copyWith(width: tWidth) : null,
//       right: rWidth != null ? side.copyWith(width: rWidth) : null,
//       bottom: bWidth != null ? side.copyWith(width: bWidth) : null,
//       borderRadius: BorderRadius.only(
//         topLeft: tWidth != null || lWidth != null ? r : Radius.zero,
//         topRight: tWidth != null || rWidth != null ? r : Radius.zero,
//         bottomRight: rWidth != null || bWidth != null ? r : Radius.zero,
//         bottomLeft: bWidth != null || lWidth != null ? r : Radius.zero,
//       ),
//       position: position,
//       duration: duration,
//       curve: curve,
//       onEnd: onEnd,
//     );
//   }

//   Widget gradient(
//     Gradient gradient, {
//     DecorationPosition position = DecorationPosition.background,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       decoration(
//         BoxDecoration(gradient: gradient),
//         position: position,
//         duration: duration,
//         curve: curve,
//         onEnd: onEnd,
//       );

//   Widget linearGradient(
//     List<Color> colors, {
//     AlignmentGeometry begin = Alignment.centerLeft,
//     AlignmentGeometry end = Alignment.centerRight,
//     TileMode tileMode = TileMode.clamp,
//     GradientTransform? transform,
//     DecorationPosition position = DecorationPosition.background,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       gradient(
//         LinearGradient(
//           colors: colors,
//           begin: begin,
//           end: end,
//           tileMode: tileMode,
//           transform: transform,
//         ),
//         position: position,
//         duration: duration,
//         curve: curve,
//         onEnd: onEnd,
//       );

//   Widget radialGradient(
//     List<Color> colors, {
//     AlignmentGeometry center = Alignment.center,
//     double radius = 0.5,
//     TileMode tileMode = TileMode.clamp,
//     AlignmentGeometry focal = Alignment.center,
//     double focalRadius = 0.0,
//     GradientTransform? transform,
//     DecorationPosition position = DecorationPosition.background,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       gradient(
//         RadialGradient(
//           colors: colors,
//           center: center,
//           radius: radius,
//           tileMode: tileMode,
//           focal: focal,
//           focalRadius: focalRadius,
//           transform: transform,
//         ),
//         position: position,
//         duration: duration,
//         curve: curve,
//         onEnd: onEnd,
//       );

//   Widget sweepGradient(
//     List<Color> colors, {
//     AlignmentGeometry center = Alignment.center,
//     double startAngle = 0.0,
//     double endAngle = math.pi * 2,
//     TileMode tileMode = TileMode.clamp,
//     GradientTransform? transform,
//     DecorationPosition position = DecorationPosition.background,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       gradient(
//         SweepGradient(
//           colors: colors,
//           center: center,
//           startAngle: startAngle,
//           endAngle: endAngle,
//           tileMode: tileMode,
//           transform: transform,
//         ),
//         position: position,
//         duration: duration,
//         curve: curve,
//         onEnd: onEnd,
//       );

//   Widget elevation(
//     double elevation, {
//     Color color = Colors.transparent,
//     Color shadowColor = const Color(0xFF000000),
//     Clip clipBehavior = Clip.none,
//     BoxShape shape = BoxShape.rectangle,
//     BorderRadius borderRadius = BorderRadius.zero,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       duration == null
//           ? PhysicalModel(
//               elevation: elevation,
//               color: color,
//               shadowColor: shadowColor,
//               clipBehavior: clipBehavior,
//               shape: shape,
//               borderRadius: borderRadius,
//               child: this,
//             )
//           : AnimatedPhysicalModel(
//               elevation: elevation,
//               color: color,
//               shadowColor: shadowColor,
//               clipBehavior: clipBehavior,
//               shape: shape,
//               borderRadius: borderRadius,
//               duration: duration,
//               curve: curve,
//               onEnd: onEnd,
//               child: this,
//             );

//   Widget radius({
//     double? all,
//     double? left,
//     double? top,
//     double? right,
//     double? bottom,
//     double? topLeft,
//     double? topRight,
//     double? bottomLeft,
//     double? bottomRight,
//     Clip clipBehavior = Clip.antiAlias,
//     CustomClipper<RRect>? clipper,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) {
//     final borderRadius = BorderRadius.only(
//       topLeft: Radius.circular(topLeft ?? top ?? left ?? all ?? 0),
//       topRight: Radius.circular(topRight ?? top ?? right ?? all ?? 0),
//       bottomLeft: Radius.circular(bottomLeft ?? bottom ?? left ?? all ?? 0),
//       bottomRight: Radius.circular(bottomRight ?? bottom ?? right ?? all ?? 0),
//     );
//     return duration == null
//         ? ClipRRect(
//             borderRadius: borderRadius,
//             clipper: clipper,
//             clipBehavior: clipBehavior,
//             child: this,
//           )
//         : AnimatedClipRRect(
//             borderRadius: borderRadius,
//             clipper: clipper,
//             clipBehavior: clipBehavior,
//             duration: duration,
//             curve: curve,
//             onEnd: onEnd,
//             child: this,
//           );
//   }
// }

// extension UiTransformExtension on Widget {
//   Widget opacity(
//     double opacity, {
//     bool alwaysIncludeSemantics = false,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       duration == null
//           ? Opacity(
//               opacity: opacity,
//               alwaysIncludeSemantics: alwaysIncludeSemantics,
//               child: this,
//             )
//           : AnimatedOpacity(
//               opacity: opacity,
//               alwaysIncludeSemantics: alwaysIncludeSemantics,
//               duration: duration,
//               curve: curve,
//               onEnd: onEnd,
//             );

//   Widget flip({
//     bool x = false,
//     bool y = false,
//     Offset? origin,
//     bool transformHitTests = true,
//     FilterQuality? filterQuality,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       duration == null
//           ? Transform.flip(
//               flipX: x,
//               flipY: y,
//               origin: origin,
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               child: this,
//             )
//           : AnimatedTransform.flip(
//               flipX: x,
//               flipY: y,
//               origin: origin,
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               duration: duration,
//               curve: curve,
//               onEnd: onEnd,
//               child: this,
//             );

//   Widget rotate(
//     double angle, {
//     Offset? origin,
//     AlignmentGeometry? alignment = Alignment.center,
//     bool transformHitTests = true,
//     FilterQuality? filterQuality,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       duration == null
//           ? Transform.rotate(
//               angle: angle,
//               origin: origin,
//               alignment: alignment,
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               child: this,
//             )
//           : AnimatedTransform.rotate(
//               angle: angle,
//               origin: origin,
//               alignment: alignment,
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               duration: duration,
//               curve: curve,
//               onEnd: onEnd,
//               child: this,
//             );

//   Widget scale({
//     double? xy,
//     double? x,
//     double? y,
//     Offset? origin,
//     Alignment? aligment = Alignment.center,
//     bool transformHitTests = true,
//     FilterQuality? filterQuality,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       duration == null
//           ? Transform.scale(
//               scaleX: x ?? xy,
//               scaleY: y ?? xy,
//               origin: origin,
//               alignment: aligment,
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               child: this,
//             )
//           : AnimatedTransform.scale(
//               scaleX: x ?? xy,
//               scaleY: y ?? xy,
//               origin: origin,
//               alignment: aligment,
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               duration: duration,
//               curve: curve,
//               onEnd: onEnd,
//               child: this,
//             );

//   Widget translate({
//     double? dx,
//     double? dy,
//     Offset? offset,
//     bool transformHitTests = true,
//     FilterQuality? filterQuality,
//     Duration? duration,
//     Curve? curve,
//     VoidCallback? onEnd,
//   }) =>
//       duration == null
//           ? Transform.translate(
//               offset: Offset(dx ?? offset?.dx ?? 0.0, dy ?? offset?.dy ?? 0.0),
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               child: this,
//             )
//           : AnimatedTransform.translate(
//               offset: Offset(dx ?? offset?.dx ?? 0.0, dy ?? offset?.dy ?? 0.0),
//               transformHitTests: transformHitTests,
//               filterQuality: filterQuality,
//               duration: duration,
//               curve: curve,
//               onEnd: onEnd,
//               child: this,
//             );
// }

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
