import 'package:nested/nested.dart';

mixin UiManager<T> {
  T addChild(SingleChildWidget child);
  T addChildren(
      List<SingleChildWidget>
          children); // direct implementation as it's more efficient
}
