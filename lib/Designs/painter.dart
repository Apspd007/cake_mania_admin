import 'package:flutter/material.dart';

class SecondShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
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

    // Paint paint = Paint()
    //   ..blendMode = BlendMode.srcOver
    //   ..color = Colors.black.withOpacity(1)
    //   ..maskFilter = new MaskFilter.blur(
    //     // BoxShadow.convertRadiusToSigma(25.0));
    //       BlurStyle.outer, 5.0);
    //       // BoxShadow.convertRadiusToSigma(25.0)

    // canvas.drawPath(path, paint);
    canvas.drawShadow(
      path,
      Colors.black,
      5,
      true,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



class FirstShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
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

    // Paint paint = Paint()
    //   ..blendMode = BlendMode.srcOver
    //   ..color = Colors.black.withOpacity(1)
    //   ..maskFilter = new MaskFilter.blur(
    //     // BoxShadow.convertRadiusToSigma(25.0));
    //       BlurStyle.outer, 5.0);
    //       // BoxShadow.convertRadiusToSigma(25.0)

    // canvas.drawPath(path, paint);
    canvas.drawShadow(
      path,
      Colors.black,
      5,
      true,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
