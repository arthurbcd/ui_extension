import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:styled_widget/styled_widget.dart';
import 'package:ui_extension/ui_extension.dart';
// import 'package:styled_widget/styled_widget.dart';

void main() {
  runApp(const MainApp());
}

am(Animate a) {
  a.scale();
}

const s1 = Duration(seconds: 1);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Positioned.
    return MaterialApp(
      home: Scaffold(
        body: UiPadding(
          left: 80.0,
          children: const [
            UiAlign(alignment: Alignment.bottomCenter),
            UiPadding(padding: EdgeInsets.all(8), left: 18),
          ],
          child: Center(
            child: Column(
              children: [
                const Ui(
                  children: [],
                ),
                Ui(
                  children: const [
                    UiAlign(alignment: Alignment.center),
                    UiConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 100)),
                    UiPadding(padding: EdgeInsets.all(8)),
                  ],
                  child: const Text('data')
                      .ui()
                      .align(Alignment.center)
                      .constrained(const BoxConstraints(maxWidth: 100))
                      .padding(padding: const EdgeInsets.all(8))
                      .sized(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// List of widgets that conflict with extensions without withProperty:
// - Container, Padding and relatives. But we wound't use them anyway, right?
// - [NetworkImage] scale,
// - [Image.constructors] scale, width, height, opacity, aligment, color.
// - [Text] scale, width, height, opacity, aligment, color.

extension on Widget {
  Widget test(double a) {
    return this;
  }
}
