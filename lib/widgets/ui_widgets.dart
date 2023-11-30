import 'package:flutter/widgets.dart';

import 'animated_flexible.dart';
import 'ui_root.dart';

abstract class UiWidget extends Ui {
  const UiWidget({
    super.key,
    this.duration,
    Curve? curve,
    this.onEnd,
    super.child,
    super.children,
  }) : _curve = curve;

  final Duration? duration;
  final Curve? _curve;
  final VoidCallback? onEnd;

  Curve get curve => _curve ?? Ui.defaultCurve;
}

class UiAlign extends UiWidget {
  const UiAlign({
    super.key,
    required this.alignment,
    this.heightFactor,
    this.widthFactor,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  });
  final AlignmentGeometry alignment;
  final double? heightFactor;
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
  ///
  /// Padding resolution prioritizes specificity:
  /// 1. [left], [top], [right], [bottom] as [EdgeInsets.only];
  /// 2. [horizontal], [vertical] as [EdgeInsets.symmetric];
  /// 3. [all] as [EdgeInsets.all];
  /// 4. [padding] as [EdgeInsets] or [EdgeInsetsDirectional].
  ///
  /// Ex: If [all] is 8, but [left] is 0 or 16, left will resolve to 0 or 16.
  const UiPadding({
    super.key,
    this.all,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.horizontal,
    this.vertical,
    this.padding,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  });
  final EdgeInsetsGeometry? padding;
  final double? all, left, top, right, bottom, horizontal, vertical;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    var padding = this.padding?.resolve(Directionality.of(context));

    padding = EdgeInsets.only(
      left: left ?? horizontal ?? all ?? padding?.left ?? 0.0,
      top: top ?? vertical ?? all ?? padding?.top ?? 0.0,
      right: right ?? horizontal ?? all ?? padding?.right ?? 0.0,
      bottom: bottom ?? vertical ?? all ?? padding?.bottom ?? 0.0,
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
    super.children,
    super.child,
  });
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

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
    super.children,
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
    super.children,
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
    super.children,
    super.child,
  });
  final int flex;
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
    super.children,
    super.child,
  });
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
  const UiConstrainedBox({
    super.key,
    required this.constraints,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  });
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

class UiSizedBox extends UiWidget {
  const UiSizedBox({
    super.key,
    this.width,
    this.height,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  });
  final double? width;
  final double? height;

  const UiSizedBox.expand({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  })  : width = double.infinity,
        height = double.infinity;

  const UiSizedBox.shrink({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  })  : width = 0.0,
        height = 0.0;

  UiSizedBox.fromSize({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
    Size? size,
  })  : width = size?.width,
        height = size?.height;

  const UiSizedBox.square({
    super.key,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
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
    super.children,
    super.child,
  });
  final Decoration decoration;
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

class UiOpacity extends UiWidget {
  const UiOpacity({
    super.key,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  });
  final double opacity;
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

class UiClipRRect extends UiWidget {
  const UiClipRRect({
    super.key,
    required this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  });
  final BorderRadiusGeometry borderRadius;
  final Clip clipBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return duration == null
        ? ClipRRect(
            borderRadius: borderRadius,
            clipBehavior: clipBehavior,
            child: child,
          )
        : AnimatedClipRRect(
            borderRadius: borderRadius,
            clipBehavior: clipBehavior,
            duration: duration!,
            curve: curve,
            onEnd: onEnd,
            child: child,
          );
  }
}

class UiPhysicalModel extends UiWidget {
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
    super.children,
    super.child,
  });
  final BoxShape shape;
  final double elevation;
  final Color color;
  final Color shadowColor;
  final BorderRadius borderRadius;
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
  const UiColoredBox({
    super.key,
    required this.color,
    super.duration,
    super.curve,
    super.onEnd,
    super.children,
    super.child,
  });
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
