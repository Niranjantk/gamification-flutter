import 'dart:async';
import 'package:flutter/material.dart';

class CustomeButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;       // called continuously while holding
  final int repeatDelay;          // speed of repeating (ms)

  const CustomeButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.repeatDelay = 80,        // default: fast smooth movement
  }) : super(key: key);

  @override
  State<CustomeButton> createState() => _CustomeButtonState();
}

class _CustomeButtonState extends State<CustomeButton> {
  bool pressed = false;
  Timer? holdTimer;

  void startHolding() {
    widget.onTap(); // call once immediately

    holdTimer = Timer.periodic(
      Duration(milliseconds: widget.repeatDelay),
      (_) => widget.onTap(),
    );
  }

  void stopHolding() {
    holdTimer?.cancel();
    holdTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => pressed = true);
        startHolding();
      },
      onTapUp: (_) {
        setState(() => pressed = false);
        stopHolding();
      },
      onTapCancel: () {
        setState(() => pressed = false);
        stopHolding();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: pressed
                ? [Colors.grey.shade800, Colors.grey.shade900]
                : [Colors.grey.shade600, Colors.grey.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: pressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    offset: const Offset(-3, -3),
                    blurRadius: 6,
                  ),
                ],
          border: Border.all(color: Colors.black.withOpacity(0.8), width: 3),
        ),
        child: Icon(
          widget.icon,
          color: pressed ? Colors.white70 : Colors.white,
          size: 40,
        ),
      ),
    );
  }
}