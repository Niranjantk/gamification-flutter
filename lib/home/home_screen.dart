import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int numberInRow = 11; // columns
  static const int rows = 16; // rows
  static const int numberOfSquares = numberInRow * rows;

  int pacmanPosition = 56;
  late List<int> boardData; // auto-generated walls

  @override
  void initState() {
    super.initState();
    boardData = generateMaze(rows, numberInRow); // generate walls
  }

  //=========================================================
  //                 MAZE GENERATOR (DFS)
  //=========================================================
  List<int> generateMaze(int rows, int cols) {
    List<List<int>> maze = List.generate(
      rows,
      (_) => List.generate(cols, (_) => 1),
    ); // 1=wall

    final List<List<int>> directions = [
      [-2, 0],
      [2, 0],
      [0, -2],
      [0, 2],
    ];

    void carve(int r, int c) {
      maze[r][c] = 0;
      directions.shuffle();

      for (var d in directions) {
        int nr = r + d[0];
        int nc = c + d[1];

        if (nr > 0 && nr < rows - 1 && nc > 0 && nc < cols - 1) {
          if (maze[nr][nc] == 1) {
            maze[r + d[0] ~/ 2][c + d[1] ~/ 2] = 0;
            carve(nr, nc);
          }
        }
      }
    }

    carve(1, 1);

    List<int> wallIndexList = [];
    int index = 0;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if (maze[r][c] == 1) wallIndexList.add(index);
        index++;
      }
    }

    return wallIndexList;
  }

  //=========================================================
  //                 MOVEMENT FUNCTIONS
  //=========================================================
  void moveUp() {
    setState(() {
      int newPos = pacmanPosition - numberInRow;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
    });
  }

  void moveDown() {
    setState(() {
      int newPos = pacmanPosition + numberInRow;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
    });
  }

  void moveLeft() {
    setState(() {
      int newPos = pacmanPosition - 1;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
    });
  }

  void moveRight() {
    setState(() {
      int newPos = pacmanPosition + 1;
      if (!boardData.contains(newPos)) pacmanPosition = newPos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          PackManBoard(
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

//=========================================================
//                 CONTROL BUTTONS
//=========================================================
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
    return Expanded(
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

//=========================================================
//                 PAC-MAN BOARD
//=========================================================
class PackManBoard extends StatelessWidget {
  final int pacmanPosition;
  final int numberInRow;
  final int rows;
  final List<int> boardData;

  const PackManBoard({
    super.key,
    required this.pacmanPosition,
    required this.numberInRow,
    required this.rows,
    required this.boardData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: numberInRow * rows,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numberInRow,
        ),
        itemBuilder: (context, index) {
          final bool isWall = boardData.contains(index);
          final bool isPacman = index == pacmanPosition;

          return Container(
            decoration: BoxDecoration(
              color: isWall ? Colors.blue[900] : Colors.black,
              borderRadius: BorderRadius.circular(isWall ? 4 : 0),
              boxShadow: isWall
                  ? [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: isPacman
                  ? const Icon(Icons.circle, size: 22, color: Colors.yellow)
                  : !isWall
                  ? Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.yellowAccent,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
