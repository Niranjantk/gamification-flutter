import 'package:flutter/material.dart';
import 'package:pacman/home/home_screen.dart';

void main(){
  runApp(PacmanGame());
}

class PacmanGame extends StatelessWidget {
  const PacmanGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
