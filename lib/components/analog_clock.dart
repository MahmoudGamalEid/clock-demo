import 'dart:math';
import 'package:clock_demo/constants.dart';
import 'package:flutter/material.dart';
import 'clock_painter.dart';

class AnalogClock extends StatefulWidget {
  AnalogClock({Key? key,required this.time}) : super(key: key);
  DateTime time;
  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: kShadowColor.withOpacity(0.14),
                  blurRadius: 64)
            ],
          ),
          child: Transform.rotate(
            angle: -pi/2,
            child: CustomPaint(
              painter: ClockPainter(context, widget.time),
            ),
          ),
        ),
      ),
    );
  }
}

