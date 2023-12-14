import 'package:flutter/material.dart';
import 'package:ui_extension/ui_extension.dart';

void main() {
  runApp(const MainApp());
}
const s1 = Duration(seconds: 1);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Ui(
            children: const [
              UiPadding(all: 16, left: 8),
              // NestClipRRect(),
              // NestPhysicalModel(),
            ],
            child: Column(
              children: [
                const Text('data')
                    .ui()
                    // .rounded(borderRadius: BorderRadius.circular(55))
                    // .physical(elevation: 5)
                    .padding(all: 50)
                    .bordered(
                        border: GradientBorder.all(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.blue,
                        ],
                      ),
                    ))
                // .paddingValue(all: 10)
                // .clipRRect(borderRadius: BorderRadius.circular(56))
                // .decorated(const BoxDecoration(color: Colors.red))
                // .sized(dimension: 150, duration: 300.ms)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
