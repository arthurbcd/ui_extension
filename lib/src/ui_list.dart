// import 'dart:collection';

import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:nested/nested.dart';

import '../widgets/ui.dart';
import 'ui_manager.dart';

class UiList extends ListBase<Widget> with UiManager<UiList> {
  /// The [Type] of widgets that won't be wrapped by [Ui] children.
  static final Set<Type> ignoreTypes = {Spacer, Gap};

  const UiList({
    required List<SingleChildWidget> uiChildren,
    required List<Widget> children,
    Set<Type> ignoreTypes = const {},
  })  : _widgets = children,
        _children = uiChildren,
        _ignoreTypes = ignoreTypes;

  final List<SingleChildWidget> _children;
  final List<Widget> _widgets;
  final Set<Type> _ignoreTypes;

  @override
  int get length => _widgets.length;

  @override
  set length(int newLength) => _widgets.length = newLength;

  @override
  UiList addChild(SingleChildWidget child) {
    return UiList(
      uiChildren: [child] + _children,
      children: _widgets,
      ignoreTypes: _ignoreTypes,
    );
  }

  @override
  UiList addChildren(List<SingleChildWidget> children) {
    return UiList(
      uiChildren: children + _children,
      children: _widgets,
      ignoreTypes: _ignoreTypes,
    );
  }

  @override
  Widget operator [](int index) {
    final widget = _widgets[index];

    if ({..._ignoreTypes, ...ignoreTypes}.contains(widget.runtimeType)) {
      return widget;
    }

    return Ui(
      children: _children,
      child: widget,
    );
  }

  @override
  void operator []=(int index, Widget value) => _widgets[index] = value;
}
