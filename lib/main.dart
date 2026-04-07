import 'package:flutter/material.dart';
import 'package:pacman/home/home_screen.dart';
import 'package:pacman/logic/maze_generator_dfs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MazeGeneratorLogicProvider(),
        ),
      ],
      child: PacmanGame(),
    ),
  );
}

class PacmanGame extends StatelessWidget {
  const PacmanGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
