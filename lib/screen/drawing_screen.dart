import 'package:flutter/material.dart';
import 'package:mystudio/components/navbar.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DrawingScreenState();
  }
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<DrawingPoint> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing'),
      ),
      bottomNavigationBar: NavBar(activeScreen: widget),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            points.add(DrawingPoint(
              point: details.localPosition,
              isNewStroke: true,
            ));
          });
        },
        onPanUpdate: (details) {
          setState(() {
            points.add(DrawingPoint(
              point: details.localPosition,
              isNewStroke: false,
            ));
          });
        },
        onPanEnd: (details) {},
        child: CustomPaint(
          painter: DrawingPainter(points.toList(growable: false)),
          child: Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(points.clear);
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}

class DrawingPoint {
  Offset point;
  bool isNewStroke;

  DrawingPoint({required this.point, required this.isNewStroke});
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].isNewStroke) {
        continue; // Skip to next point
      } else {
        canvas.drawLine(points[i - 1].point, points[i].point, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) {
    //return true;
    return oldDelegate.points.length != points.length;
  }
}
