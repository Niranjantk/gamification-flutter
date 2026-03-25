
import 'package:flutter/material.dart';

class PacManControlButton extends StatelessWidget {
  final VoidCallback up;
  final VoidCallback down;
  final VoidCallback left;
  final VoidCallback right;

  const PacManControlButton({
    super.key,
    required this.up,
    required this.down,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: up,
            child: const Icon(Icons.arrow_drop_up, size: 40),
          ),
            
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: left,
                child: const Icon(Icons.arrow_left, size: 40),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: right,
                child: const Icon(Icons.arrow_right, size: 40),
              ),
            ],
          ),
            
          ElevatedButton(
            onPressed: down,
            child: const Icon(Icons.arrow_drop_down, size: 40),
          ),
        ],
      ),
    );
  }
}