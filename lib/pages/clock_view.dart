import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;
  const ClockView({Key? key, required this.size}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1,), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var fillBrush = Paint()..color = const Color(0xFF444974);

    var outLineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = const Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;
    var minHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      // ..color = Colors.deepOrangeAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/30;

    var hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      // ..color = Colors.deepOrangeAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width/24;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outLineBrush);


    var hourHandX = centerX + radius *.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
        // cos(dateTime.minute * 30 * pi / 180);
    var hourHandY = centerX + radius *.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
        // sin(dateTime.minute * 30 * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX +
        radius *.6*cos(dateTime.minute * 6 * pi / 180);
            // cos((dateTime.hour * 30 + dateTime.minute * .5) * pi / 180);
    var minHandY = centerX +
        radius *.6 *sin(dateTime.minute * 6 * pi / 180);
            // sin((dateTime.hour * 30 + dateTime.minute * .5) * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    // canvas.drawCircle(center, radius * 0.12, centerFillBrush);
    // var dashBrush = Paint()
    //   ..color = Colors.white54
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 1;
    // var outerCircleRadius = radius;
    // var innerCircleRadius = radius -14;
    // for (double i =0; i<360; i  +=12) {
    //   var x1= centerX+outerCircleRadius * cos(i*pi / 180);
    //   var y1= centerX+outerCircleRadius* sin(i*pi / 180);
    //   var x2= centerX+innerCircleRadius* sin(i*pi / 180);
    //   var y2= centerX+innerCircleRadius* sin(i*pi / 180);
    //   canvas.drawLine(Offset(x1,y1), Offset(x2,y2),dashBrush);
    // }

    var outerRadius = radius;
    var dashBrush = Paint()
      ..color = Colors.white54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var innerRadius = radius * 0.9;
    for (var i = 0; i < 360; i += 12) {
      var x1 = centerX + outerRadius * cos(i * pi / 180);
      var y1 = centerY + outerRadius * sin(i * pi / 180);

      var x2 = centerX + innerRadius * cos(i * pi / 180);
      var y2 = centerY + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
