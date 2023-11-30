import 'package:flutter/widgets.dart';

class StateBuilder<T> extends StatefulWidget {
  const StateBuilder(
    this.value,
    this.builder, {
    super.key,
    this.onInit,
    this.onPostInit,
    this.onUpdate,
    this.onDispose,
    this.onPostDispose,
  });

  final T value;
  final Widget Function(T value, StateBuilderState<T>) builder;
  final ValueSetter<T>? onInit;
  final void Function(T value, StateBuilderState<T> setValue)? onPostInit;
  final ValueChanged<T>? onUpdate;
  final ValueSetter<T>? onDispose;
  final ValueSetter<T>? onPostDispose;

  @override
  State<StateBuilder> createState() => StateBuilderState<T>();
}

class StateBuilderState<T> extends State<StateBuilder<T>> {
  late T _value = widget.value;

  T get value => _value;

  void setValue(T value) {
    widget.onUpdate?.call(value);
    setState(() => this._value = value);
  }

  @override
  void initState() {
    widget.onInit?.call(_value);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPostInit?.call(_value, this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_value, this);
  }

  @override
  void dispose() {
    widget.onDispose?.call(_value);
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPostDispose?.call(_value);
    });
  }
}
