library ui_extension;

// import 'dart:ffi';
import 'dart:math' as math;
import 'dart:ui';

import 'package:animated_value/animated_value.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:ui_extension/widgets/animated_flexible.dart';
import 'package:ui_extension/widgets/ui_root.dart';

import 'widgets/ui_widgets.dart';

export 'package:ui_extension/widgets/state_builder.dart';
export 'package:ui_extension/widgets/ui_root.dart';
export 'package:ui_extension/widgets/ui_widgets.dart';
export 'package:ui_extension/widgets/value_builder.dart';

part 'extensions/context.dart';
part 'extensions/element.dart';
part 'extensions/widget.dart';
part 'extensions/ui.dart';

// Todo:
// - [ ] layout widget extensions
// https://pub.dev/packages/styled_widget


// - [ ] layout context extensions

// - [ ] layout widgets
// https://pub.dev/packages/gap

// - [ ] layout breakpoints
// https://pub.dev/packages/responsive_builder
// https://pub.dev/packages/responsive_sizer
// https://pub.dev/packages/layout

// - [ ] layout transitions
// https://pub.dev/packages/page_transition

// - [ ] layout dialog, contextless
// https://pub.dev/packages/awesome_dialog
// https://pub.dev/packages/flutter_smart_dialog
// https://pub.dev/packages/asuka