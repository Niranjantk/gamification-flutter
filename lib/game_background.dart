import 'package:flutter/material.dart';
import 'dart:math' as math;

class GameBackground extends StatelessWidget {
  final double x; // Horizontal world position
  final double y; // Vertical world position (replaces old Y)

  const GameBackground({Key? key, required this.x, required this.y})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Sky/Void background
        Container(color: const Color(0xFF1A1A1A)),

        // Scrolling Map Image
        Positioned(
          left: -x * 500, // Sensitivity of scrolling
          top: -y * 500,
          child: Image.asset(
            'assets/background/map.png',
            fit: BoxFit.none, // Keep original size for scrolling
            scale: 0.5, // Adjust scale if needed
          ),
        ),

        // Floating bits for depth (optional decorations)
        _buildFloatingBit(top: 100, left: 100, size: 20),
        _buildFloatingBit(top: 400, left: 300, size: 15),
        _buildFloatingBit(top: 250, left: 600, size: 25),
      ],
    );
  }

  Widget _buildFloatingBit(
      {required double top, required double left, required double size}) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: size,
          height: size,
          color: Colors.white10,
        ),
      ),
    );
  }
}
