import 'dart:math' as math;

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

  /// Sets [AlignmentGeometry].
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

  /// Sets [EdgeInsetsGeometry]. Fallbacks to shortcuts if null.
  final EdgeInsetsGeometry? padding;

  /// Shortcut for [EdgeInsetsGeometry]. Ignored if [padding] is set.
  final double? left, top, right, bottom, horizontal, vertical, all;

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
    required this.constraints,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [BoxConstraints].
  final BoxConstraints constraints;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
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
    required this.maxWidth,
    required this.maxHeight,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [LimitedBox] values.
  final double maxWidth, maxHeight;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? LimitedBox(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            child: child,
          )
        : AnimatedLimitedBox(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiOverflowBox extends UiWidget {
  const UiOverflowBox({
    super.key,
    required this.alignment,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [OverflowBox.alignment].
  final AlignmentGeometry alignment;

  /// Sets [OverflowBox] values.
  final double? minWidth, maxWidth, minHeight, maxHeight;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
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
  const UiSizedBox({
    super.key,
    this.width,
    this.height,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [SizedBox] values.
  final double? width, height;

  const UiSizedBox.expand({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : width = double.infinity,
        height = double.infinity;

  const UiSizedBox.shrink({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  })  : width = 0.0,
        height = 0.0;

  UiSizedBox.fromSize({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
    Size? size,
  })  : width = size?.width,
        height = size?.height;

  const UiSizedBox.square({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
    double? dimension,
  })  : width = dimension,
        height = dimension;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
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

class UiBorderedBox extends UiWidget {
  /// [UiWidget] for [BorderedBox], or [AnimatedBorderedBox] if [duration] is present.
  const UiBorderedBox({
    super.key,
    this.border,
    this.all,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.horizontal,
    this.vertical,
    this.color = const Color(0xFF000000),
    this.style = BorderStyle.solid,
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.borderRadius,
    this.radius,
    this.radiusX,
    this.radiusY,
    this.shape = BoxShape.rectangle,
    this.position = DecorationPosition.background,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [BoxBorder]. Fallbacks to shortcuts if null.
  final BoxBorder? border;

  /// Shortcut for [BoxBorder]. Ignored if [border] is set.
  final double? left, top, right, bottom, horizontal, vertical, all;

  /// Shortcut for [BoxBorder]. Ignored if [border] is set.
  final Color color;

  /// Shortcut for [BoxBorder]. Ignored if [border] is set.
  final BorderStyle style;

  /// Shortcut for [BoxBorder]. Ignored if [border] is set.
  final double strokeAlign;

  /// Sets [BorderRadiusGeometry]. Fallbacks to shortcuts if null.
  final BorderRadiusGeometry? borderRadius;

  /// Shortcut for [BorderRadiusGeometry]. Ignored if [borderRadius] is set.
  final double? radius, radiusX, radiusY;

  /// Sets [BoxShape].
  final BoxShape shape;

  /// Sets [DecorationPosition].
  final DecorationPosition position;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    //radius
    final r = Radius.elliptical(radiusX ?? radius ?? 0, radiusY ?? radius ?? 0);

    //width
    final wL = left ?? horizontal ?? all;
    final wT = top ?? vertical ?? all;
    final wR = right ?? horizontal ?? all;
    final wB = bottom ?? vertical ?? all;

    BorderSide side(double? width) {
      if (width == null) return BorderSide.none;
      return BorderSide(
        color: color,
        style: style,
        strokeAlign: strokeAlign,
        width: width,
      );
    }

    final border = this.border ??
        Border(
          left: side(wL),
          top: side(wT),
          right: side(wR),
          bottom: side(wB),
        );

    final borderRadius = this.borderRadius ??
        BorderRadius.only(
          topLeft: wT != null || wL != null ? r : Radius.zero,
          topRight: wT != null || wR != null ? r : Radius.zero,
          bottomRight: wB != null || wR != null ? r : Radius.zero,
          bottomLeft: wB != null || wL != null ? r : Radius.zero,
        );

    return duration == null
        ? BorderedBox(
            border: border,
            borderRadius: borderRadius,
            shape: shape,
            position: position,
            child: child,
          )
        : AnimatedBorderedBox(
            border: border,
            borderRadius: borderRadius,
            shape: shape,
            position: position,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiOpacity extends UiWidget {
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

/// TODO: Create RoundedBox
class UiClipRRect extends UiWidget {
  const UiClipRRect({
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [ClipRRect.borderRadius].
  final BorderRadiusGeometry borderRadius;

  /// Sets [ClipRRect.clipper].
  final CustomClipper<RRect>? clipper;

  /// Sets [ClipRRect.clipBehavior].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? ClipRRect(
            borderRadius: borderRadius,
            clipper: clipper,
            clipBehavior: clipBehavior,
            child: child,
          )
        : AnimatedClipRRect(
            borderRadius: borderRadius,
            clipper: clipper,
            clipBehavior: clipBehavior,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiPhysicalModel extends UiWidget {
  /// [UiWidget] for [PhysicalModel], or [AnimatedPhysicalModel] if [duration] is present.
  const UiPhysicalModel({
    super.key,
    this.shape = BoxShape.rectangle,
    this.elevation = 0.0,
    this.color = const Color(0xFF000000),
    this.shadowColor = const Color(0xFF000000),
    this.borderRadius = BorderRadius.zero,
    this.clipBehavior = Clip.none,
    super.duration,
    super.curve,
    super.onEnd,
    super.child,
  });

  /// Sets [PhysicalModel.shape].
  final BoxShape shape;

  /// Sets [PhysicalModel.elevation].
  final double elevation;

  /// Sets [PhysicalModel.color].
  final Color color;

  /// Sets [PhysicalModel.shadowColor].
  final Color shadowColor;

  /// Sets [PhysicalModel.borderRadius].
  final BorderRadius borderRadius;

  /// Sets [PhysicalModel.clipBehavior].
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(duration == null || child != null);
    return duration == null
        ? PhysicalModel(
            shape: shape,
            elevation: elevation,
            color: color,
            shadowColor: shadowColor,
            borderRadius: borderRadius,
            clipBehavior: clipBehavior,
            child: child,
          )
        : AnimatedPhysicalModel(
            shape: shape,
            elevation: elevation,
            color: color,
            shadowColor: shadowColor,
            borderRadius: borderRadius,
            clipBehavior: clipBehavior,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child!,
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
