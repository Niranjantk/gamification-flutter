import 'dart:async';

import 'package:flutter/material.dart';

class PacManControlButton extends StatelessWidget {
  final VoidCallback up;
  final VoidCallback down;
  final VoidCallback left;
  final VoidCallback right;
  final VoidCallback resetPacman;
  final VoidCallback resetBoard;

  const PacManControlButton({
    super.key,
    required this.up,
    required this.down,
    required this.left,
    required this.right,
    required this.resetPacman,
    required this.resetBoard,
  });

  Widget buildButton(IconData icon, VoidCallback action) {
    return GestureDetector(
      onTap: action, // <-- Fires ONLY once per tap
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 40, color: Colors.white),
      ),
    );
  }

  Widget buildSquareButton(IconData icon, Color color, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 32, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // UP
          
          HoldButton(onTap: up, icon: Icons.arrow_drop_up),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSquareButton(
                Icons.refresh,
                Colors.orangeAccent,
                resetPacman,
              ),
              const SizedBox(width: 20),

              HoldButton(onTap: left, icon: Icons.arrow_left),
              const SizedBox(width: 20),
              HoldButton(onTap: right, icon: Icons.arrow_right),

              const SizedBox(width: 20),
              buildSquareButton(Icons.autorenew, Colors.redAccent, resetBoard),
            ],
          ),

          const SizedBox(height: 16),

          // DOWN
          HoldButton(onTap: down, icon: Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

class HoldButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const HoldButton({super.key, required this.onTap, required this.icon});

  @override
  State<HoldButton> createState() => _HoldButtonState();
}

class _HoldButtonState extends State<HoldButton> {
  Timer? timer;

  void startHolding() {
    widget.onTap(); // first tap
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      widget.onTap(); // repeat while holding
    });
  }

  void stopHolding() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // single press
      onLongPressStart: (_) => startHolding(),
      onLongPressEnd: (_) => stopHolding(),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Icon(widget.icon, size: 40, color: Colors.white),
      ),
    );
  }
}
