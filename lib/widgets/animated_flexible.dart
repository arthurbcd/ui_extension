import 'dart:math' as math;
import 'dart:ui';

import 'package:animated_value/animated_value.dart';
import 'package:flutter/material.dart';

class AnimatedFlexible extends AnimatedValue<int> {
  AnimatedFlexible({
    FlexFit fit = FlexFit.loose,
    int flex = 1,
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    required Widget super.child,
  }) : super(
          value: flex,
          lerp: (a, b, t) => IntTween(begin: a, end: b).lerp(t),
          builder: (_, value, __) {
            return Flexible(
              fit: fit,
              flex: value,
              child: child,
            );
          },
        );
}

class AnimatedExpanded extends AnimatedFlexible {
  AnimatedExpanded({
    super.flex,
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    required super.child,
  }) : super(fit: FlexFit.tight);
}

class AnimatedClipRRect extends AnimatedValue<BorderRadiusGeometry?> {
  AnimatedClipRRect({
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    super.child,
  }) : super(
          value: borderRadius,
          lerp: BorderRadiusGeometry.lerp,
          builder: (context, value, __) {
            return ClipRRect(
              borderRadius: value!,
              clipper: clipper,
              clipBehavior: clipBehavior,
              child: child,
            );
          },
        );
}

class AnimatedColoredBox extends AnimatedValue<Color?> {
  AnimatedColoredBox({
    Color color = const Color(0x00000000),
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    super.child,
  }) : super(
          value: color,
          lerp: Color.lerp,
          builder: (_, value, __) {
            return ColoredBox(
              color: value!,
              child: child,
            );
          },
        );
}

class AnimatedConstrainedBox extends AnimatedValue<BoxConstraints?> {
  AnimatedConstrainedBox({
    required BoxConstraints constraints,
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    super.child,
  }) : super(
          value: constraints,
          lerp: BoxConstraints.lerp,
          builder: (_, value, __) {
            return ConstrainedBox(
              constraints: value!,
              child: child,
            );
          },
        );
}

class _SizedBoxValue {
  final double? width;
  final double? height;

  _SizedBoxValue(this.width, this.height);

  static _SizedBoxValue lerp(
    _SizedBoxValue? a,
    _SizedBoxValue? b,
    double t,
  ) {
    return _SizedBoxValue(
      lerpDouble(a?.width, b?.width, t),
      lerpDouble(a?.height, b?.height, t),
    );
  }
}

class AnimatedSizedBox extends AnimatedValue<_SizedBoxValue> {
  AnimatedSizedBox({
    double? width,
    double? height,
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    super.child,
  }) : super(
          value: _SizedBoxValue(width, height),
          lerp: _SizedBoxValue.lerp,
          builder: (_, value, __) {
            return SizedBox(
              width: value.width,
              height: value.height,
              child: child,
            );
          },
        );

  AnimatedSizedBox.square({
    double? dimension,
    Key? key,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    required Duration duration,
    Widget? child,
  }) : this(
          width: dimension,
          height: dimension,
          key: key,
          curve: curve,
          onEnd: onEnd,
          duration: duration,
          child: child,
        );

  AnimatedSizedBox.fromSize({
    Size? size,
    Key? key,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    required Duration duration,
    Widget? child,
  }) : this(
          width: size?.width,
          height: size?.height,
          key: key,
          curve: curve,
          onEnd: onEnd,
          duration: duration,
          child: child,
        );
}

class AnimatedDecoratedBox extends AnimatedValue<Decoration?> {
  AnimatedDecoratedBox({
    required Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    super.child,
  }) : super(
          value: decoration,
          lerp: Decoration.lerp,
          builder: (_, value, __) {
            return DecoratedBox(
              decoration: value!,
              position: position,
              child: child,
            );
          },
        );
}

class _TransformValue {
  final Matrix4 transform;
  final AlignmentGeometry? alignment;
  final Offset? origin;

  _TransformValue({
    required this.alignment,
    required this.transform,
    required this.origin,
  });

  static _TransformValue lerp(
    _TransformValue? a,
    _TransformValue? b,
    double t,
  ) {
    return _TransformValue(
      alignment: AlignmentGeometry.lerp(a?.alignment, b?.alignment, t),
      transform: Matrix4Tween(begin: a?.transform, end: b?.transform).lerp(t),
      origin: Offset.lerp(a?.origin, b?.origin, t),
    );
  }
}

class AnimatedTransform extends AnimatedValue<_TransformValue> {
  AnimatedTransform({
    required Matrix4 transform,
    AlignmentGeometry? alignment,
    Offset? origin,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    super.key,
    super.curve,
    super.onEnd,
    required super.duration,
    super.child,
  }) : super(
          value: _TransformValue(
            alignment: alignment,
            transform: transform,
            origin: origin,
          ),
          lerp: _TransformValue.lerp,
          builder: (_, value, __) {
            return Transform(
              transform: value.transform,
              alignment: value.alignment,
              origin: value.origin,
              transformHitTests: transformHitTests,
              filterQuality: filterQuality,
              child: child,
            );
          },
        );

  AnimatedTransform.rotate({
    Key? key,
    required double angle,
    Offset? origin,
    AlignmentGeometry? alignment = Alignment.center,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    required Duration duration,
    Widget? child,
  }) : this(
          key: key,
          transform: _computeRotation(angle),
          origin: origin,
          alignment: alignment,
          transformHitTests: transformHitTests,
          filterQuality: filterQuality,
          curve: curve,
          onEnd: onEnd,
          duration: duration,
          child: child,
        );

  AnimatedTransform.translate({
    Key? key,
    Offset offset = Offset.zero,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    required Duration duration,
    Widget? child,
  }) : this(
          key: key,
          transform: Matrix4.translationValues(offset.dx, offset.dy, 0.0),
          curve: curve,
          onEnd: onEnd,
          duration: duration,
          child: child,
        );

  AnimatedTransform.scale({
    Key? key,
    double? scale,
    double? scaleX,
    double? scaleY,
    Offset? origin,
    AlignmentGeometry? alignment = Alignment.center,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    required Duration duration,
    Widget? child,
  }) : this(
          key: key,
          transform: () {
            assert(!(scale == null && scaleX == null && scaleY == null),
                "At least one of 'scale', 'scaleX' and 'scaleY' is required to be non-null");
            assert(scale == null || (scaleX == null && scaleY == null),
                "If 'scale' is non-null then 'scaleX' and 'scaleY' must be left null");
            return Matrix4.diagonal3Values(
              scale ?? scaleX ?? 1.0,
              scale ?? scaleY ?? 1.0,
              1.0,
            );
          }(),
          alignment: alignment,
          origin: origin,
          curve: curve,
          onEnd: onEnd,
          duration: duration,
          child: child,
        );

  AnimatedTransform.flip({
    Key? key,
    bool flipX = false,
    bool flipY = false,
    Offset? origin,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
    required Duration duration,
    Widget? child,
  }) : this(
          key: key,
          transform: Matrix4.diagonal3Values(
            flipX ? -1.0 : 1.0,
            flipY ? -1.0 : 1.0,
            1.0,
          ),
          alignment: Alignment.center,
          origin: origin,
          curve: curve,
          onEnd: onEnd,
          duration: duration,
          child: child,
        );

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
