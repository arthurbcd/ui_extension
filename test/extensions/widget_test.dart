// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ui_extension/ui_extension.dart';

// void main() {
//   group('widget extensions', () {
//     const Widget box = SizedBox.square(dimension: 100);
//     test('alignment', () {
//       const a = Align(
//         alignment: Alignment.topRight,
//         heightFactor: 2,
//         widthFactor: 3,
//         child: box,
//       );

//       final b = box.alignment(
//         Alignment.topRight,
//         heightFactor: 2,
//         widthFactor: 3,
//       ) as Align;

//       expect(b.alignment, a.alignment);
//       expect(b.heightFactor, a.heightFactor);
//       expect(b.widthFactor, a.widthFactor);
//       expect(b.child, a.child);
//     });

//     test('border', () {
//       final a = DecoratedBox(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.red,
//             width: 2,
//             style: BorderStyle.solid,
//           ),
//         ),
//         child: box,
//       );

//       final b = box.borderWidth(
//         color: Colors.red,
//         all: 2,
//         style: BorderStyle.solid,
//       ) as DecoratedBox;

//       expect(b.decoration, a.decoration);
//       expect(b.child, a.child);
//     });

//     test('color', () {
//       const a = ColoredBox(
//         color: Colors.red,
//         child: box,
//       );

//       final b = box.color(Colors.red) as ColoredBox;

//       expect(b.color, a.color);
//       expect(b.child, a.child);
//     });

//     test('constraints', () {
//       final a = ConstrainedBox(
//         constraints: const BoxConstraints.tightFor(width: 100),
//         child: box,
//       );

//       final b = box.constraints(const BoxConstraints.tightFor(width: 100))
//           as ConstrainedBox;

//       expect(b.constraints, a.constraints);
//       expect(b.child, a.child);
//     });

//     test('decoration', () {
//       const a = DecoratedBox(
//         decoration: BoxDecoration(color: Colors.red),
//         child: box,
//       );

//       final b = box.decoration(const BoxDecoration(color: Colors.red))
//           as DecoratedBox;

//       expect(b.decoration, a.decoration);
//       expect(b.child, a.child);
//     });

//     test('dimension', () {
//       final a = ConstrainedBox(
//         constraints: BoxConstraints.tight(const Size.square(100)),
//         child: box,
//       );

//       final b = box.dimension(100) as ConstrainedBox;

//       expect(b.constraints, a.constraints);
//       expect(b.child, a.child);
//     });

//     test('padding', () {
//       const a = Padding(
//         padding: EdgeInsets.all(8),
//         child: box,
//       );

//       final b = box.padding(all: 8) as Padding;

//       expect(b.padding, a.padding);
//       expect(b.child, a.child);
//     });

//     test('radius', () {
//       final a = ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: box,
//       );

//       final b = box.radius(all: 8) as ClipRRect;

//       expect(b.borderRadius, a.borderRadius);
//       expect(b.child, a.child);
//     });

//     test('scale', () {
//       final a = Transform.scale(
//         scale: 2,
//         child: box,
//       );

//       final b = box.scale(xy: 2) as Transform;

//       expect(b.transform, a.transform);
//       expect(b.child, a.child);
//     });

//     test('opacity', () {
//       const a = Opacity(
//         opacity: 0.5,
//         child: box,
//       );

//       final b = box.opacity(0.5) as Opacity;

//       expect(b.opacity, a.opacity);
//       expect(b.child, a.child);
//     });

//     test('width', () {
//       final a = ConstrainedBox(
//         constraints: const BoxConstraints.tightFor(width: 100),
//         child: box,
//       );

//       final b = box.width(100) as ConstrainedBox;

//       expect(b.constraints, a.constraints);
//       expect(b.child, a.child);
//     });

//     test('height', () {
//       final a = ConstrainedBox(
//         constraints: const BoxConstraints.tightFor(height: 100),
//         child: box,
//       );

//       final b = box.height(100) as ConstrainedBox;

//       expect(b.constraints, a.constraints);
//       expect(b.child, a.child);
//     });

//     test('position', () {
//       const a = Positioned(
//         bottom: 0,
//         left: 0,
//         child: box,
//       );

//       final b = box.position(bottom: 0, left: 0) as Positioned;

//       expect(b.bottom, a.bottom);
//       expect(b.left, a.left);
//       expect(b.child, a.child);
//     });
//   });
// }
