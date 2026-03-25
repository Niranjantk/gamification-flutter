import 'package:flutter/material.dart';
import 'package:pacman/home/bord_widget.dart';
import 'package:pacman/home/button_widgets.dart';
import 'package:pacman/logic/maze_generator_dfs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int numberInRow = 11; // columns
  static const int rows = 15; // rows
  final List<int> startAndEnding = [144, 20];
  int pacmanPosition = 144;
  late List<int> boardData; // auto-generated walls
 String turtlePositons = "right";
  @override
  void initState() {
    super.initState();
    boardData = generateMaze(rows, numberInRow); // generate walls
  }

  void moveUp() {
    setState(() {
      int newPos = pacmanPosition - numberInRow;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
      turtlePositons = "up";
    });
  }

  void moveDown() {
    setState(() {
      int newPos = pacmanPosition + numberInRow;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
      turtlePositons = "down";
    });
  }

  void moveLeft() {
    setState(() {
      int newPos = pacmanPosition - 1;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
      turtlePositons = "left";
    });
  }

  void moveRight() {
    setState(() {
      int newPos = pacmanPosition + 1;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
      turtlePositons = "right";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          PackManBoard(
            
            turtlePositons : turtlePositons,
            startAndEnding: startAndEnding,
            pacmanPosition: pacmanPosition,
            numberInRow: numberInRow,
            rows: rows,
            boardData: boardData,
          ),

          PacManControlButton(
            up: moveUp,
            down: moveDown,
            left: moveLeft,
            right: moveRight,
          ),
        ],
      ),
    );
  }
}
