import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final BuildContext context;
  final DateTime dateTime;
  ClockPainter(this.context, this.dateTime);
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    // minute arm values
    double minX =
        centerX + size.width * 0.47 * cos((dateTime.minute * 6) * pi / 180);
    double minY =
        centerY + size.width * 0.47 * sin((dateTime.minute * 6) * pi / 180);
    // draw minute arm
    canvas.drawLine(
        center,
        Offset(minX, minY),
        Paint()
          ..color = Theme.of(context).colorScheme.tertiary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);
    // hour arm values
    double hourX = centerX +
        size.width *
            0.35 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = centerY +
        size.width *
            0.35 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    // draw hour arm
    canvas.drawLine(
        center,
        Offset(hourX, hourY),
        Paint()
          ..color = Theme.of(context).colorScheme.secondary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);

    // seconds arm values
    double secondX =
        centerX + size.width * 0.49 * cos((dateTime.second * 6) * pi / 180);
    double secondY =
        centerY + size.width * 0.49 * sin((dateTime.second * 6) * pi / 180);
    // draw seconds arm
    canvas.drawLine(center, Offset(secondX, secondY),
        Paint()..color = Theme.of(context).primaryColor);

    //Draw center
    Paint dotPainter = Paint()
      ..color = Theme.of(context).primaryIconTheme.color!;
    canvas.drawCircle(center, 10, dotPainter);
    canvas.drawCircle(
        center, 10, Paint()..color = Theme.of(context).backgroundColor);
    canvas.drawCircle(center, 5, dotPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}