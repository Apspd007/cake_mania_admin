import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    var controlPoint1 =
        Offset(((40 / 100) * size.width), ((128 / 100) * size.height));
    var controlPoint2 =
        Offset(((50 / 100) * size.width), ((40 / 100) * size.height));
    var endPoint = Offset(size.width, ((70 / 100) * size.height));

    path 
      ..moveTo(0, 0)
      ..lineTo(0, ((65 / 100) * size.height))
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0.0)
      ..close();
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


class SecondWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    var controlPoint1 =
        Offset(((42 / 100) * size.width), ((123.5 / 100) * size.height));
    var controlPoint2 =
        Offset(((50 / 100) * size.width), ((40 / 100) * size.height));
    var endPoint = Offset(size.width, ((70 / 100) * size.height));

    path
      ..moveTo(0, 0)
      ..lineTo(0, ((66 / 100) * size.height))
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0.0)
      ..close();
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
