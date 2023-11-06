import 'package:flutter/widgets.dart';

class ValueBuilder<T> extends StatefulWidget {
  const ValueBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.onInit,
    this.onPostInit,
    this.onUpdate,
    this.onDispose,
    this.onPostDispose,
  });

  final T value;
  final Widget Function(T value, ValueSetter<T> setValue) builder;
  final ValueSetter<T>? onInit;
  final void Function(T value, ValueSetter<T> setValue)? onPostInit;
  final ValueChanged<T>? onUpdate;
  final ValueSetter<T>? onDispose;
  final ValueSetter<T>? onPostDispose;

  @override
  State<ValueBuilder> createState() => _ValueBuilderState<T>();
}

class _ValueBuilderState<T> extends State<ValueBuilder<T>> {
  late T value = widget.value;
  void setter(T value) {
    widget.onUpdate?.call(value);
    setState(() => this.value = value);
  }

  @override
  void initState() {
    widget.onInit?.call(value);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPostInit?.call(value, setter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(value, setter);
  }

  @override
  void dispose() {
    widget.onDispose?.call(value);
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPostDispose?.call(value);
    });
  }
}
