import 'package:flutter/material.dart';
import 'package:pacman/home/bord_widget.dart';
import 'package:pacman/home/button_widgets.dart';
import 'package:pacman/logic/maze_generator_dfs.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    // Start timer + connect Game Over popup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final maze = Provider.of<MazeGeneratorLogicProvider>(context, listen: false);

      // When timer reaches 0 → show popup
      maze.onTimeOver = () {
        gameTimerOver();
      };

      maze.startGameTimer(); // Start only once
    });
  }

  @override
  Widget build(BuildContext context) {
    final maze = Provider.of<MazeGeneratorLogicProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pacman Game"),
        backgroundColor: Colors.grey[900],
        actions: [
          // Score
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              Text(" Score: ${maze.score}", style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 20),
            ],
          ),

          // Timer
          Row(
            children: [
              const Icon(Icons.timer, color: Colors.yellow),
              Text(" Time: ${maze.timer}", style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 20),
            ],
          ),

          // Lives
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.red),
              Text(" Lives: ${maze.lives}", style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),

      backgroundColor: Colors.grey[900],

      body: Consumer<MazeGeneratorLogicProvider>(
        builder: (context, maze, child) {
          return Column(
            children: [
              Expanded(
                child: PackManBoard(
                  turtlePositions: maze.turtleDirection,
                  startAndEnding: maze.startAndEnding,
                  pacmanPosition: maze.pacmanPositions,
                  numberInRow: maze.numberInRows,
                  rows: maze.rows,
                  boardData: maze.boardData,
                ),
              ),

              PacManControlButton(
                resetBoard: maze.resetGame,
                resetPacman: maze.resetPacmanPosition,
                up: maze.moveUp,
                down: maze.moveDown,
                left: maze.moveLeft,
                right: maze.moveRight,
              ),
            ],
          );
        },
      ),
    );
  }

  // GAME OVER POPUP
  void gameTimerOver() {
    showDialog(
      context: context,
      barrierDismissible: false, // prevents tap outside to close
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: const Text("Time is over!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close popup
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}