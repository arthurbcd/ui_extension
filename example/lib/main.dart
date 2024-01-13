import 'package:flutter/material.dart';
import 'package:ui_extension/ui_extension.dart';
// import 'package:ui_extension/ui_extension.dart';

void main() {
  runApp(const MainApp());
}

const s1 = Duration(seconds: 1);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Material;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Ui(
            children: const [
              UiPadding(all: 16, left: 8),
              // NestClipRRect(),
              // NestPhysicalModel(),
            ],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    elevation: 50,
                    child: Container(
                      height: 300,
                      width: 200,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(15),
                  Container(
                    height: 300,
                    width: 200,
                    color: Colors.white,
                  ).ui().bordered(
                        radius: 95,
                        depth: -1,
                        elevation: 5,
                        width: 5,
                        color: Colors.red,
                        gradient: const SweepGradient(colors: [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.blue,
                          Colors.indigo,
                          Colors.purple,
                          Colors.red,
                        ]),
                        // width: 15,
                        duration: const Duration(seconds: 1),
                      ),
                  const Gap(15),
                  UiBordered(
                    border: Border.all(
                      width: 5,
                      strokeAlign: -5,
                      // gradient: const LinearGradient(colors: [
                      //   Colors.red,
                      //   Colors.orange,
                      //   Colors.yellow,
                      //   Colors.green,
                      //   Colors.blue,
                      //   Colors.indigo,
                      //   Colors.purple,
                      // ]),
                    ),
                    borderRadius: BorderRadius.circular(65),
                    child: Container(
                      // color: Colors.red,
                      height: 200,
                      width: 300,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  )
                      .ui() //
                      .constrained(maxHeight: 150)
                      .bordered(radius: 50, depth: -1, duration: s1)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
