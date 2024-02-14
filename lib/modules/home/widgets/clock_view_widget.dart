// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CustomColors {
  static const Color primaryTextColor = Colors.white;
  static const Color dividerColor = Colors.white54;
  static const Color pageBackgroundColor = Color(0xFF2D2F41);
  static const Color menuBackgroundColor = Color(0xFF242634);

  static const Color clockBG = Color(0xFF444974);
  static const Color clockOutline = Color(0xFFEAECFF);
  static const Color secHandColor = Colors.orangeAccent;
  static const Color minHandStatColor = Color(0xFF748EF6);
  static const Color minHandEndColor = Color(0xFF77DDFF);
  static const Color hourHandStatColor = Color(0xFFC279FB);
  static const Color hourHandEndColor = Color(0xFFEA74AB);
  static const Color myColor = Colors.indigo;
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [
    const Color(0xFFFE6197),
    const Color(0xFFFFB463)
  ];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}

class ClockView extends StatefulWidget {
  final double? size;

  const ClockView({super.key, this.size});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    final fillBrush = Paint()..color = CustomColors.clockBG;
    final outlineBrush = Paint()
      ..color = CustomColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;
    final centerDotBrush = Paint()..color = CustomColors.clockOutline;

    final secHandBrush = Paint()
      ..color = CustomColors.secHandColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;

    final minHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        CustomColors.minHandStatColor,
        CustomColors.minHandEndColor
      ]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;

    final hourHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        CustomColors.hourHandStatColor,
        CustomColors.hourHandEndColor
      ]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;

    final dashBrush = Paint()
      ..color = CustomColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    final hourHandX = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    final hourHandY = centerY +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    final minHandX =
        centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    final minHandY =
        centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    final secHandX =
        centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    final secHandY =
        centerY + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius * 0.12, centerDotBrush);

    final outerRadius = radius;
    final innerRadius = radius * 0.9;
    for (var i = 0; i < 360; i += 12) {
      final x1 = centerX + outerRadius * cos(i * pi / 180);
      final y1 = centerY + outerRadius * sin(i * pi / 180);

      final x2 = centerX + innerRadius * cos(i * pi / 180);
      final y2 = centerY + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
