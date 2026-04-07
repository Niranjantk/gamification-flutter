import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mario/game_background.dart';
import 'package:mario/mario.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mario position (World coordinates)
  double worldX = 0.0;
  double worldY = 0.0;

  // Mario direction
  String marioDirection = "idle";
  Timer? idleTimer;

  // -------------------------
  //     MOVE LOGIC
  // -------------------------
  void _setIdle() {
    idleTimer?.cancel();
    idleTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() => marioDirection = "idle");
      }
    });
  }

  void moveLeft() {
    setState(() {
      worldX -= 0.020;
      marioDirection = "left";
    });
    _setIdle();
  }

  void moveRight() {
    setState(() {
      worldX += 0.020;
      marioDirection = "right";
    });
    _setIdle();
  }

  void moveUp() {
    setState(() {
      worldY -= 0.020;
      marioDirection = "up";
    });
    _setIdle();
  }

  void moveDown() {
    setState(() {
      worldY += 0.020;
      marioDirection = "down";
    });
    _setIdle();
  }

  // -------------------------
  //            UI
  // -------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. BACKGROUND (Isometric Floor)
          GameBackground(x: worldX, y: worldY),

          // 2. CHARACTER (Always centered, world moves)
          Center(
            child: Mario(direction: marioDirection),
          ),

          // 3. CONTROLS OVERLAY (4-way D-pad)
          Positioned(
            bottom: 40,
            left: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Up button
                _buildGameButton(
                  icon: Icons.keyboard_arrow_up,
                  onTap: moveUp,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Left button
                    _buildGameButton(
                      icon: Icons.keyboard_arrow_left,
                      onTap: moveLeft,
                    ),
                    const SizedBox(width: 40),
                    // Right button
                    _buildGameButton(
                      icon: Icons.keyboard_arrow_right,
                      onTap: moveRight,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Down button
                _buildGameButton(
                  icon: Icons.keyboard_arrow_down,
                  onTap: moveDown,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Timer? holdTimer;

Widget _buildGameButton({
  required IconData icon,
  required VoidCallback onTap,
  bool isCircular = false,
}) {
  void startHold() {
    onTap(); // run once immediately
    holdTimer = Timer.periodic(
      const Duration(milliseconds: 80), // movement speed
      (_) => onTap(),
    );
  }

  void stopHold() {
    holdTimer?.cancel();
    holdTimer = null;
  }

  return GestureDetector(
    onTapDown: (_) => startHold(),
    onTapUp: (_) => stopHold(),
    onTapCancel: () => stopHold(),

    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white24,
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(12),
        border: Border.all(color: Colors.white54, width: 2),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 32,
      ),
    ),
  );
}
}
