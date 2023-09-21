import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    required this.radius,
    required this.color,
    super.key,
    this.child,
  });

  final double radius;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: ClipOval(
        child: ColoredBox(
          color: color,
          child: child,
        ),
      ),
    );
  }
}
