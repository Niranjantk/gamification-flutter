import 'dart:async';
import 'package:flutter/material.dart';

class Mario extends StatefulWidget {
  final String direction; // idle, left, right
  const Mario({Key? key, required this.direction}) : super(key: key);

  @override
  State<Mario> createState() => _MarioState();
}

class _MarioState extends State<Mario> {
  int frame = 1;
  Timer? animationTimer;

  @override
  void didUpdateWidget(Mario oldWidget) {
    super.didUpdateWidget(oldWidget);

    // direction changed → restart animation correctly
    if (oldWidget.direction != widget.direction) {
      startAnimation();
    }
  }

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() {
    animationTimer?.cancel();

    // Animation speed (milliseconds per frame)
    // 60-80ms is usually a good range for smooth 2D animations
    int speed = widget.direction == "idle" ? 120 : 80;

    animationTimer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      if (mounted) {
        setState(() {
          frame++;
          // All states now have 8 frames
          if (frame > 8) frame = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String image;

    if (widget.direction == "left") {
      image = "assets/running_left/running$frame.png";
    } else if (widget.direction == "right") {
      image = "assets/running_right/runningr$frame.png";
    } else if (widget.direction == "up") {
      // Up animation has 7 frames (based on analysis)
      int upFrame = frame > 7 ? 1 : frame;
      image = "assets/running_up/up$upFrame.png";
    } else if (widget.direction == "down") {
      image = "assets/running_down/down$frame.png";
    } else {
      // Idle animation
      image = "assets/standing/frount/standing$frame.png";
    }

    return SizedBox(
      width: 120,
      height: 120,
      child: Image.asset(
        image,
        // Using filterQuality for smoother rendering
        filterQuality: FilterQuality.medium,
        gaplessPlayback: true,
      ),
    );
  }
}
