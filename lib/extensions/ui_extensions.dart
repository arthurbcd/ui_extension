import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import '../src/ui_list.dart';
import '../src/ui_manager.dart';
import '../widgets/ui.dart';
import '../widgets/ui_widgets.dart';

extension UiWidgetExtension on Widget {
  Ui ui({
    List<SingleChildWidget>? children,
  }) {
    return Ui.empty(
      children: children,
      child: this,
    );
  }
}

extension A on List<Widget> {
  UiList ui({
    Set<Type> ignoreTypes = const {},
    List<SingleChildWidget> children = const [],
  }) {
    return UiList(
      uiChildren: children,
      ignoreTypes: ignoreTypes,
      children: this,
    );
  }
}

extension UiPositionExtension<T extends UiManager<T>> on T {
  /// Adds [UiAlign].
  T align(
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

  /// Adds [UiPadding].
  T padding({
    EdgeInsetsGeometry? padding, // overrides below
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    //
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

  /// Adds [UiPositioned].
  T positioned({
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

  /// Adds [UiPositioned.fill].
  T positionedFill({
    double? left = 0.0,
    double? top = 0.0,
    double? right = 0.0,
    double? bottom = 0.0,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) {
    return addChild(UiPositioned.fill(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
    ));
  }

  /// Adds [UiFlexible].
  T flexible({
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

  /// Adds [UiExpanded].
  T expanded({
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

  /// Adds [UiConstrainedBox].
  T constrained({
    BoxConstraints? constraints, // overrides below
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    //
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiConstrainedBox(
        constraints: constraints,
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds [UiLimitedBox].
  T limited({
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiLimitedBox(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds [UiOverflowBox].
  T overflow({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    AlignmentGeometry alignment = Alignment.center,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiOverflowBox(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        alignment: alignment,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds [UiSizedBox].
  T sized({
    double? width,
    double? height,
    Size? size,
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

  /// Adds [UiDecoratedBox].
  T decorated(
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

  /// Adds [UiOpacity].
  T opacity(
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

  /// Adds [UiColoredBox].
  T colored(
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

  /// Adds [UiTransform.rotate].
  T rotated(
    double angle, {
    Offset? origin,
    AlignmentGeometry? alignment = Alignment.center,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiTransform.rotate(
        angle: angle,
        origin: origin,
        alignment: alignment,
        transformHitTests: transformHitTests,
        filterQuality: filterQuality,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds [UiTransform.translate].
  T translated(
    Offset offset, {
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiTransform.translate(
        offset: offset,
        transformHitTests: transformHitTests,
        filterQuality: filterQuality,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds [UiTransform.scale].
  T scaled({
    double? xy,
    double? x,
    double? y,
    Offset? origin,
    Alignment? aligment = Alignment.center,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiTransform.scale(
        scaleX: x ?? xy,
        scaleY: y ?? xy,
        origin: origin,
        alignment: aligment,
        transformHitTests: transformHitTests,
        filterQuality: filterQuality,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds [UiTransform.flip].
  T flipped({
    bool x = false,
    bool y = false,
    Offset? origin,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) =>
      addChild(UiTransform.flip(
        flipX: x,
        flipY: y,
        origin: origin,
        transformHitTests: transformHitTests,
        filterQuality: filterQuality,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
      ));

  /// Adds [UiBordered].
  T bordered({
    // border.
    BoxBorder? border, // overrides below
    Gradient? gradient,
    Color color = const Color(0xFF000000),
    double width = 0.0,
    BorderStyle style = BorderStyle.solid,
    double strokeAlign = BorderSide.strokeAlignInside,

    // clip.
    BorderRadiusGeometry? borderRadius, // overrides below
    double depth = 1.0,
    double radius = 0.0,
    BoxShape shape = BoxShape.rectangle,
    Clip clipBehavior = Clip.antiAlias,

    // shadow.
    double elevation = 0.0,
    Color shadowColor = const Color(0xFF000000),

    // ui.
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
  }) {
    return addChild(UiBordered(
      border: border,
      gradient: gradient,
      color: color,
      width: width,
      style: style,
      strokeAlign: strokeAlign,
      borderRadius: borderRadius,
      depth: depth,
      radius: radius,
      shape: shape,
      clipBehavior: clipBehavior,
      elevation: elevation,
      shadowColor: shadowColor,
      duration: duration,
      curve: curve,
      onEnd: onEnd,
    ));
  }
}
