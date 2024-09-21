import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomProgressRingWidget extends StatefulWidget {
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;
  final double progress;

  const CustomProgressRingWidget(
      {super.key,
      this.size = 80.0,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.teal,
      this.strokeWidth = 8.0,
      required this.progress});

  @override
  State<CustomProgressRingWidget> createState() =>
      _CustomProgressRingWidgetState();
}

class _CustomProgressRingWidgetState extends State<CustomProgressRingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  // Color get backgroundColor =>
  //     widget.progress == 1.0 ? Colors.teal : Colors.white;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation =
        Tween<double>(begin: 0.0, end: widget.progress).animate(controller)
          ..addListener(() {
            setState(() {}); // State 업데이트를 위해 setState 호출
          });

    controller.forward();
  }

  @override
  void didUpdateWidget(CustomProgressRingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // progress 값이 변경되었는지 확인
    if (oldWidget.progress != widget.progress) {
      // 애니메이션을 업데이트합니다.
      animation = Tween<double>(begin: oldWidget.progress, end: widget.progress)
          .animate(controller)
        ..addListener(() {
          setState(() {}); // State 업데이트를 위해 setState 호출
        });
      controller
        ..reset() // 애니메이션 컨트롤러를 리셋
        ..forward(); // 애니메이션을 시작
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: RingPainter(
        progress: animation.value,
        backgroundColor: widget.backgroundColor,
        progressColor: widget.progressColor,
        strokeWidth: widget.strokeWidth,
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  RingPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Color backgroundColor = progress == 1.0 ? Colors.white : Colors.teal;
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width - strokeWidth) / 2;
    canvas.drawCircle(center, radius, backgroundPaint);
    double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
