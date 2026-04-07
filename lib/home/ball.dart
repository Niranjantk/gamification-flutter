import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  const Ball({
    super.key,
    required this.isPacman,
    required this.isWall,
    required this.turtlePositions, // "up", "down", "left", "right"
  });

  final bool isPacman;
  final bool isWall;
  final String turtlePositions;

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPacman) {
      // Rotate the icon based on direction
      double rotationAngle = 0;
      switch (widget.turtlePositions) {
        case "up":
          rotationAngle = -3.14159 / 2; // 90° up
          break;
        case "down":
          rotationAngle = 3.14159 / 2; // 90° down
          break;
        case "left":
          rotationAngle = 3.14159; // 180° left
          break;
        case "right":
          rotationAngle = 0; // default right
          break;
      }

      return Center(
        child: Transform.rotate(
          angle: rotationAngle,
          child: SizedBox(
            width: 70, // adjust size to fit your grid cell
            height: 70,
            child: Image.asset("assets/turtle.png", fit: BoxFit.contain),
          ),
        ),
      );
    }

    // Animated pellet for non-wall tiles
    if (!widget.isWall) {
      return Center(
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _pulseAnimation.value, child: child);
          },
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.yellowAccent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    // Empty for walls
    return const SizedBox.shrink();
  }
}
