import 'package:flutter/material.dart';

class Triangle extends StatelessWidget {

  const Triangle({
    Key? key,
    this.left = true
  }) : super(key: key);

  final bool left;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RotationTransition(
      turns: AlwaysStoppedAnimation(left ? 90 / 360 : 270 / 360),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.height * 0.0375, size.height * 0.0375),
            painter: TriangleFill()
          ),
          CustomPaint(
            size: Size(size.height * 0.0375, size.height * 0.0375),
            painter: TriangleStroke()
          )
        ],
      )
    );
  }
}

class TriangleStroke extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TriangleFill extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}