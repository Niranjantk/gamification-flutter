import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (isPacman) {
      // Rotate the icon based on direction
      double rotationAngle = 0;
      switch (turtlePositions) {
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
            child: Image.asset(
              "assets/turtle.png",
              fit: BoxFit.contain, // scale image to fit the box
            ),
          ),
        ),
      );
    }

    // Normal pellet for non-wall tiles
    return Center(
      child: !isWall
          ? Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.yellowAccent,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}
