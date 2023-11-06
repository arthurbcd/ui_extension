import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            child: Stack(
              children: [
                const Ui() //
                    .color(Colors.blueGrey, duration: 1.seconds)
                    .positioned(all: 0),
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
