import 'package:flutter/material.dart';

/// A border that draws a gradient instead of a solid color.
class GradientBorder extends Border {
  /// Creates a gradient border.
  ///
  /// If [gradient] is present, then [top], [right], [bottom], and [left] colors
  /// are ignored. Otherwise, a [SweepGradient] is created from the colors of
  /// the sides.
  ///
  const GradientBorder({
    Gradient? gradient,
    super.bottom = BorderSide.none,
    super.left = BorderSide.none,
    super.right = BorderSide.none,
    super.top = BorderSide.none,
  }) : _gradient = gradient;

  /// A uniform gradient border applied to all sides.
  const GradientBorder.fromBorderSide({
    required Gradient gradient,
    required BorderSide side,
  })  : _gradient = gradient,
        super.fromBorderSide(side);

  /// Creates a gradient border with symmetrical vertical and horizontal sides.
  const GradientBorder.symmetric({
    required Gradient gradient,
    BorderSide vertical = BorderSide.none,
    BorderSide horizontal = BorderSide.none,
  })  : _gradient = gradient,
        super.symmetric(vertical: vertical, horizontal: horizontal);

  /// A uniform gradient border applied to all sides.
  GradientBorder.all({
    required Gradient gradient,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    double strokeAlign = BorderSide.strokeAlignInside,
  }) : this.fromBorderSide(
            gradient: gradient,
            side: BorderSide(
              width: width,
              style: style,
              strokeAlign: strokeAlign,
            ));

  final Gradient? _gradient;

  /// The gradient used to draw the border.
  Gradient get gradient {
    return _gradient ??
        SweepGradient(
          colors: [
            right.color,
            bottom.color,
            left.color,
            top.color,
            right.color,
          ],
        );
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    paintNonUniformGradientBorder(
      canvas,
      rect,
      shape: shape,
      borderRadius: borderRadius,
      textDirection: textDirection,
      gradient: gradient,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    );
  }

  /// Paints a border with a [Gradient].
  static void paintNonUniformGradientBorder(
    Canvas canvas,
    Rect rect, {
    required Gradient gradient,
    required BorderRadius? borderRadius,
    required TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderSide top = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
    BorderSide left = BorderSide.none,
  }) {
    final RRect borderRect;
    switch (shape) {
      case BoxShape.rectangle:
        borderRect = (borderRadius ?? BorderRadius.zero)
            .resolve(textDirection)
            .toRRect(rect);
        break;
      case BoxShape.circle:
        assert(borderRadius == null,
            'A borderRadius cannot be given when shape is a BoxShape.circle.');
        borderRect = RRect.fromRectAndRadius(
          Rect.fromCircle(center: rect.center, radius: rect.shortestSide / 2.0),
          Radius.circular(rect.width),
        );
        break;
    }
    final Paint paint = Paint()..shader = gradient.createShader(rect);
    final RRect inner = _deflateRRect(
        borderRect,
        EdgeInsets.fromLTRB(left.strokeInset, top.strokeInset,
            right.strokeInset, bottom.strokeInset));
    final RRect outer = _inflateRRect(
        borderRect,
        EdgeInsets.fromLTRB(left.strokeOutset, top.strokeOutset,
            right.strokeOutset, bottom.strokeOutset));
    canvas.drawDRRect(outer, inner, paint);
  }

  static RRect _inflateRRect(RRect rect, EdgeInsets insets) {
    return RRect.fromLTRBAndCorners(
      rect.left - insets.left,
      rect.top - insets.top,
      rect.right + insets.right,
      rect.bottom + insets.bottom,
      topLeft: (rect.tlRadius + Radius.elliptical(insets.left, insets.top))
          .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
      topRight: (rect.trRadius + Radius.elliptical(insets.right, insets.top))
          .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
      bottomRight:
          (rect.brRadius + Radius.elliptical(insets.right, insets.bottom))
              .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
      bottomLeft:
          (rect.blRadius + Radius.elliptical(insets.left, insets.bottom))
              .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
    );
  }

  static RRect _deflateRRect(RRect rect, EdgeInsets insets) {
    return RRect.fromLTRBAndCorners(
      rect.left + insets.left,
      rect.top + insets.top,
      rect.right - insets.right,
      rect.bottom - insets.bottom,
      topLeft: (rect.tlRadius - Radius.elliptical(insets.left, insets.top))
          .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
      topRight: (rect.trRadius - Radius.elliptical(insets.right, insets.top))
          .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
      bottomRight:
          (rect.brRadius - Radius.elliptical(insets.right, insets.bottom))
              .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
      bottomLeft:
          (rect.blRadius - Radius.elliptical(insets.left, insets.bottom))
              .clamp(minimum: Radius.zero), // ignore_clamp_double_lint
    );
  }
}
