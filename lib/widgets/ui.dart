// Generated by Dart Safe Data Class Generator. * Change this header on extension settings *
// ignore_for_file: avoid_dynamic_calls, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../src/ui_manager.dart';

class UiBuilder extends SingleChildBuilder {
  const UiBuilder({
    super.key,
    required super.builder,
    super.child,
  });
}

class Ui extends Nested implements UiManager<Ui> {
  /// Creates a [Ui] widget.
  Ui({
    super.key,
    required super.children,
    super.child,
  })  : assert(children.isNotEmpty),
        _children = children,
        _child = child;

  Ui.empty({
    super.key,
    required List<SingleChildWidget>? children,
    required Widget child,
  })  : _children = children ?? const [],
        _child = child,
        super(children: children ?? const [_NoChild()], child: child);

  final List<SingleChildWidget> _children;
  final Widget? _child;

  /// The default curve for all [UiWidget].
  static Curve defaultCurve = Curves.linear;

  @override
  Ui addChild(SingleChildWidget child) {
    return Ui(
      key: key,
      children: [child] + _children,
      child: _child,
    );
  }

  @override
  Ui addChildren(List<SingleChildWidget> children) {
    return Ui(
      key: key,
      children: children + _children,
      child: _child,
    );
  }
}

/// A widget that does nothing.
class _NoChild extends Widget implements SingleChildWidget {
  const _NoChild();

  @override
  SingleChildWidgetElementMixin createElement() {
    assert(
      false,
      '''
    Extension ui() built without any SingleChildWidget. This usually happens 
    when ui() children property is left empty and is never filled. 
    
    For example:
    - Text('data').ui(); <- Not allowed.

    You can fix this by removing or adding a child extension:
    - Text('data').ui().sized();
    ''',
    );
    return _UiElement(this);
  }
}

class _UiElement extends Element with SingleChildWidgetElementMixin {
  _UiElement(super.widget);

  @override
  bool get debugDoingBuild => false;

  @override
  // ignore: must_call_super
  void performRebuild() {}
}
