part of '/ui_extension.dart';

extension UiWidgetExtension on Widget {
  Ui ui([List<SingleChildWidget>? children]) {
    return Ui(
      children: children ?? [],
      child: this,
    );
  }
}
