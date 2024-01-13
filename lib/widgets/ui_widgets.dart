import 'dart:math' as math;

// import 'package:bordered/bordered.dart';
import 'package:bordered/bordered.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'animated_widgets.dart';
import 'ui.dart';

/// A Widget that extends [SingleChildWidget] and is compatible with [Ui.children].
///
/// This is the base class for all [Ui] widgets.
abstract class UiWidget extends SingleChildStatelessWidget {
  /// Creates a [SingleChildWidget] compatible with [Ui.children].
  ///
  /// Typically returns a [Widget], or [ImplicitlyAnimatedWidget] if [duration] is present.
  const UiWidget({
    super.key,
    this.duration,
    Curve? curve,
    this.onEnd,
    super.child,
  }) : _curve = curve;

  final Duration? duration;
  final Curve? _curve;
  final VoidCallback? onEnd;

  Curve get curve => _curve ?? Ui.defaultCurve;
}

/// `UiAlign` is a custom widget that extends `UiWidget`.
/// It wraps the Flutter `Align` or `AnimatedAlign` widget,
/// depending on whether an animation duration is provided.
class UiAlign extends UiWidget {
  /// Creates a [UiWidget] that builder [Align], or [AnimatedAlign] if [duration] is present.
  const UiAlign({
    Key? key,
    required this.alignment,
    this.heightFactor,
    this.widthFactor,
    Duration? duration,
    Curve? curve,
    VoidCallback? onEnd,
    Widget? child,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
          child: child,
        );

  /// Sets [Align.alignment].
  final AlignmentGeometry alignment;

  /// Sets [Align.heightFactor].
  final double? heightFactor;

  /// Sets [Align.widthFactor].
  final double? widthFactor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? Align(
            alignment: alignment,
            heightFactor: heightFactor,
            widthFactor: widthFactor,
            child: child,
          )
        : AnimatedAlign(
            alignment: alignment,
            heightFactor: heightFactor,
            widthFactor: widthFactor,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiPadding extends UiWidget {
  /// [UiWidget] for [Padding], or [AnimatedPadding] if [duration] is present.
  const UiPadding({
    super.key,
    this.padding,
    this.all,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.horizontal,
    this.vertical,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [Padding.padding].
  final EdgeInsetsGeometry? padding;

  /// Sets [Padding.padding]. Ignored if [padding] is set.
  final double? left, top, right, bottom;

  /// Sets [Padding.padding]. Ignored if [left], [top], [right] or [bottom] is set.
  final double? horizontal, vertical;

  /// Sets [Padding.padding]. Ignored if [horizontal] or [vertical] is set.
  final double? all;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final padding = this.padding ??
        EdgeInsets.only(
          left: left ?? horizontal ?? all ?? 0.0,
          top: top ?? vertical ?? all ?? 0.0,
          right: right ?? horizontal ?? all ?? 0.0,
          bottom: bottom ?? vertical ?? all ?? 0.0,
        );

    return duration == null
        ? Padding(
            padding: padding,
            child: child,
          )
        : AnimatedPadding(
            padding: padding,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiPositioned extends UiWidget {
  /// [UiWidget] for [Positioned], or [AnimatedPositioned] if [duration] is present.
  const UiPositioned({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [Positioned] values.
  final double? left, top, right, bottom, width, height;

  UiPositioned.fromRect({
    super.key,
    required Rect rect,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null;

  UiPositioned.fromRelativeRect({
    super.key,
    required RelativeRect rect,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : left = rect.left,
        top = rect.top,
        right = rect.right,
        bottom = rect.bottom,
        width = null,
        height = null;

  const UiPositioned.fill({
    super.key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : width = null,
        height = null;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);
    return duration == null
        ? Positioned(
            left: left,
            top: top,
            right: right,
            bottom: bottom,
            width: width,
            height: height,
            child: child!,
          )
        : AnimatedPositioned(
            left: left,
            top: top,
            right: right,
            bottom: bottom,
            width: width,
            height: height,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child!,
          );
  }
}

class UiFlexible extends UiWidget {
  /// [UiWidget] for [Flexible], or [AnimatedFlexible] if [duration] is present.
  const UiFlexible({
    super.key,
    this.flex = 1,
    this.fit = FlexFit.loose,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [Flexible.flex].
  final int flex;

  /// Sets [Flexible.fit].
  final FlexFit fit;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);
    return duration == null
        ? Flexible(
            flex: flex,
            fit: fit,
            child: child!,
          )
        : AnimatedFlexible(
            flex: flex,
            fit: fit,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child!,
          );
  }
}

class UiExpanded extends UiWidget {
  /// [UiWidget] for [Expanded], or [AnimatedExpanded] if [duration] is present.
  const UiExpanded({
    super.key,
    this.flex = 1,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [Expanded.flex].
  final int flex;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);
    return duration == null
        ? Expanded(
            flex: flex,
            child: child!,
          )
        : AnimatedExpanded(
            flex: flex,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child!,
          );
  }
}

class UiConstrainedBox extends UiWidget {
  /// [UiWidget] for [ConstrainedBox], or [AnimatedConstrainedBox] if [duration] is present.
  const UiConstrainedBox({
    super.key,
    this.constraints,
    this.minSize,
    this.maxSize,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.minDimension,
    this.maxDimension,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [ConstrainedBox.constraints].
  final BoxConstraints? constraints;

  /// Sets [ConstrainedBox.constraints]. Ignored if [constraints] is set.
  final Size? minSize, maxSize;

  /// Sets [ConstrainedBox.constraints]. Ignored if [minSize] or [maxSize] is set.
  final double? minWidth, minHeight, maxWidth, maxHeight;

  /// Sets [ConstrainedBox.constraints]. Ignored if [minWidth], [maxWidth], [minHeight] or [maxHeight] is set.
  final double? minDimension, maxDimension;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final constraints = this.constraints ??
        const BoxConstraints().copyWith(
          minWidth: minSize?.width ?? minWidth ?? minDimension,
          minHeight: minSize?.height ?? minHeight ?? minDimension,
          maxWidth: maxSize?.width ?? maxWidth ?? maxDimension,
          maxHeight: maxSize?.height ?? maxHeight ?? maxDimension,
        );

    return duration == null
        ? ConstrainedBox(
            constraints: constraints,
            child: child,
          )
        : AnimatedConstrainedBox(
            constraints: constraints,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiLimitedBox extends UiWidget {
  /// [UiWidget] for [LimitedBox], or [AnimatedLimitedBox] if [duration] is present.
  const UiLimitedBox({
    super.key,
    this.maxSize,
    this.maxWidth,
    this.maxHeight,
    this.maxDimension,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [LimitedBox] values.
  final Size? maxSize;

  /// Sets [LimitedBox] values. Ignored if [maxSize] is set.
  final double? maxWidth, maxHeight;

  /// Sets [LimitedBox] values. Ignored if [maxWidth] or [maxHeight] is set.
  final double? maxDimension;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final w = maxSize?.width ?? maxWidth ?? maxDimension ?? double.infinity;
    final h = maxSize?.height ?? maxHeight ?? maxDimension ?? double.infinity;

    return duration == null
        ? LimitedBox(
            maxWidth: w,
            maxHeight: h,
            child: child,
          )
        : AnimatedLimitedBox(
            maxWidth: w,
            maxHeight: h,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiOverflowBox extends UiWidget {
  /// [UiWidget] for [OverflowBox], or [AnimatedOverflowBox] if [duration] is present.
  const UiOverflowBox({
    super.key,
    this.alignment = Alignment.center,
    this.minSize,
    this.maxSize,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.minDimension,
    this.maxDimension,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [OverflowBox.alignment].
  final AlignmentGeometry alignment;

  /// Sets [OverflowBox] values.
  final Size? minSize, maxSize;

  /// Sets [OverflowBox] values. Ignored if [minSize] or [maxSize] is set.
  final double? minWidth, minHeight, maxWidth, maxHeight;

  /// Sets [OverflowBox] values. Ignored if [minWidth], [maxWidth], [minHeight] or [maxHeight] is set.
  final double? minDimension, maxDimension;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final minWidth = minSize?.width ?? this.minWidth ?? minDimension;
    final minHeight = minSize?.height ?? this.minHeight ?? minDimension;
    final maxWidth = maxSize?.width ?? this.maxWidth ?? maxDimension;
    final maxHeight = maxSize?.height ?? this.maxHeight ?? maxDimension;

    return duration == null
        ? OverflowBox(
            alignment: alignment,
            minWidth: minWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            maxHeight: maxHeight,
            child: child,
          )
        : AnimatedOverflowBox(
            alignment: alignment,
            minWidth: minWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            maxHeight: maxHeight,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiSizedBox extends UiWidget {
  /// [UiWidget] for [SizedBox], or [AnimatedSizedBox] if [duration] is present.
  const UiSizedBox({
    super.key,
    this.size,
    this.width,
    this.height,
    this.dimension,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [SizedBox] values.
  final Size? size;

  /// Sets [SizedBox] values. Ignored if [size] is set.
  final double? width, height;

  /// Sets [SizedBox] values. Ignored if [width] or [height] is set.
  final double? dimension;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final width = size?.width ?? this.width ?? dimension;
    final height = size?.height ?? this.height ?? dimension;

    return duration == null
        ? SizedBox(
            width: width,
            height: height,
            child: child,
          )
        : AnimatedSizedBox(
            width: width,
            height: height,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiDecoratedBox extends UiWidget {
  /// [UiWidget] for [DecoratedBox], or [AnimatedDecoratedBox] if [duration] is present.
  const UiDecoratedBox({
    super.key,
    required this.decoration,
    this.position = DecorationPosition.background,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [DecoratedBox.decoration].
  final Decoration decoration;

  /// Sets [DecoratedBox.position].
  final DecorationPosition position;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? DecoratedBox(
            decoration: decoration,
            position: position,
            child: child,
          )
        : AnimatedDecoratedBox(
            decoration: decoration,
            position: position,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiBordered extends UiWidget {
  /// [UiWidget] for [Bordered], or [AnimatedBordered] if [duration] is present.
  const UiBordered({
    super.key,
    // border.
    this.border,
    this.gradient,
    this.color = const Color(0xFF000000),
    this.width = 0.0,
    this.style = BorderStyle.solid,
    this.strokeAlign = BorderSide.strokeAlignInside, // -1.0

    // clip.
    this.borderRadius,
    this.depth = 1.0,
    this.radius = 0.0,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.antiAlias,

    // shadow.
    this.elevation = 0.0,
    this.shadowColor = const Color(0xFF000000),

    // ui.
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [Bordered.border].
  final BoxBorder? border;

  /// Sets [UiBorder.gradient] as border. Ignored if [border] is set.
  final Gradient? gradient;

  /// Sets [BorderSide.color] as border. Ignored if [gradient] is set.
  final Color color;

  /// Sets [BorderSide.width] as border. Ignored if [border] is set.
  final double width;

  /// Sets [BorderSide.style] as border. Ignored if [border] is set.
  final BorderStyle style;

  /// Sets [BorderSide.strokeAlign] as border. Ignored if [border] is set.
  final double strokeAlign;

  /// Sets [Bordered.borderRadius].
  final BorderRadiusGeometry? borderRadius;

  /// Sets [UiRadius] as borderRadius. Ignored if [borderRadius] is set.
  final double depth, radius;

  /// Sets [Bordered.shape]. Use either it or [borderRadius].
  final BoxShape shape;

  /// Sets [Bordered.clipBehavior].
  final Clip clipBehavior;

  /// Sets [Bordered.elevation].
  final double elevation;

  /// Sets [Bordered.shadowColor].
  final Color shadowColor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final border = this.border ??
        UiBorder.all(
          gradient: gradient,
          color: color,
          width: width,
          style: style,
          strokeAlign: strokeAlign,
        );

    final borderRadius = this.borderRadius ??
        BorderRadius.all(UiRadius.circular(radius, depth: depth));

    return duration == null
        ? Bordered(
            border: border,
            borderRadius: borderRadius,
            clipBehavior: clipBehavior,
            elevation: elevation,
            shadowColor: shadowColor,
            shape: shape,
            child: child,
          )
        : AnimatedBordered(
            border: border,
            borderRadius: borderRadius,
            clipBehavior: clipBehavior,
            shape: shape,
            elevation: elevation,
            shadowColor: shadowColor,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiOpacity extends UiWidget {
  /// [UiWidget] for [Opacity], or [AnimatedOpacity] if [duration] is present.
  const UiOpacity({
    super.key,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [Opacity.opacity].
  final double opacity;

  /// Sets [Opacity.alwaysIncludeSemantics].
  final bool alwaysIncludeSemantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? Opacity(
            opacity: opacity,
            alwaysIncludeSemantics: alwaysIncludeSemantics,
            child: child,
          )
        : AnimatedOpacity(
            opacity: opacity,
            alwaysIncludeSemantics: alwaysIncludeSemantics,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}
class UiColoredBox extends UiWidget {
  /// [UiWidget] for [ColoredBox], or [AnimatedColoredBox] if [duration] is present.
  const UiColoredBox({
    super.key,
    required this.color,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [ColoredBox.color].
  final Color color;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? ColoredBox(
            color: color,
            child: child,
          )
        : AnimatedColoredBox(
            color: color,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiTransform extends UiWidget {
  /// [UiWidget] for [Transform], or [AnimatedTransform] if [duration] is present.
  const UiTransform({
    super.key,
    required this.transform,
    this.origin,
    this.alignment,
    this.transformHitTests = true,
    this.filterQuality,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// [UiWidget] for [Transform.rotate], or [AnimatedTransform.rotate] if [duration] is present.
  UiTransform.rotate({
    super.key,
    required double angle,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  }) : transform = _computeRotation(angle);

  /// [UiWidget] for [Transform.scale], or [AnimatedTransform.scale] if [duration] is present.
  UiTransform.translate({
    super.key,
    required Offset offset,
    this.transformHitTests = true,
    this.filterQuality,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : transform = Matrix4.translationValues(offset.dx, offset.dy, 0.0),
        origin = null,
        alignment = null;

  /// [UiWidget] for [Transform.scale], or [AnimatedTransform.scale] if [duration] is present.
  UiTransform.scale({
    super.key,
    double? scale,
    double? scaleX,
    double? scaleY,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : assert(!(scale == null && scaleX == null && scaleY == null),
            "At least one of 'scale', 'scaleX' and 'scaleY' is required to be non-null"),
        assert(scale == null || (scaleX == null && scaleY == null),
            "If 'scale' is non-null then 'scaleX' and 'scaleY' must be left null"),
        transform = Matrix4.diagonal3Values(
            scale ?? scaleX ?? 1.0, scale ?? scaleY ?? 1.0, 1.0);

  /// [UiWidget] for [Transform.translate], or [AnimatedTransform.translate] if [duration] is present.
  UiTransform.flip({
    super.key,
    bool flipX = false,
    bool flipY = false,
    this.origin,
    this.transformHitTests = true,
    this.filterQuality,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : alignment = Alignment.center,
        transform = Matrix4.diagonal3Values(
            flipX ? -1.0 : 1.0, flipY ? -1.0 : 1.0, 1.0);

  /// Sets [Transform.transform].
  final Matrix4 transform;

  /// Sets [Transform.origin].
  final Offset? origin;

  /// Sets [Transform.alignment].
  final AlignmentGeometry? alignment;

  /// Sets [Transform.transformHitTests].
  final bool transformHitTests;

  /// Sets [Transform.filterQuality].
  final FilterQuality? filterQuality;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? Transform(
            transform: transform,
            origin: origin,
            alignment: alignment,
            transformHitTests: transformHitTests,
            filterQuality: filterQuality,
            child: child,
          )
        : AnimatedTransform(
            transform: transform,
            origin: origin,
            alignment: alignment,
            transformHitTests: transformHitTests,
            filterQuality: filterQuality,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }

  static Matrix4 _computeRotation(double radians) {
    assert(radians.isFinite,
        'Cannot compute the rotation matrix for a non-finite angle: $radians');
    if (radians == 0.0) {
      return Matrix4.identity();
    }
    final double sin = math.sin(radians);
    if (sin == 1.0) {
      return _createZRotation(1.0, 0.0);
    }
    if (sin == -1.0) {
      return _createZRotation(-1.0, 0.0);
    }
    final double cos = math.cos(radians);
    if (cos == -1.0) {
      return _createZRotation(0.0, -1.0);
    }
    return _createZRotation(sin, cos);
  }

  static Matrix4 _createZRotation(double sin, double cos) {
    final Matrix4 result = Matrix4.zero();
    result.storage[0] = cos;
    result.storage[1] = sin;
    result.storage[4] = -sin;
    result.storage[5] = cos;
    result.storage[10] = 1.0;
    result.storage[15] = 1.0;
    return result;
  }
}
