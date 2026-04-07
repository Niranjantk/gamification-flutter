import 'package:flutter/material.dart';
import 'package:pacman/home/ball.dart';
import 'package:pacman/logic/maze_generator_dfs.dart';
import 'package:provider/provider.dart';

class PackManBoard extends StatefulWidget {
  final int pacmanPosition;
  final int numberInRow;
  final int rows;
  final List<int> startAndEnding;
  final List<int> boardData;
  final String turtlePositions;

  const PackManBoard({
    super.key,
    required this.pacmanPosition,
    required this.numberInRow,
    required this.rows,
    required this.boardData,
    required this.startAndEnding,
    required this.turtlePositions,
  });

  @override
  State<PackManBoard> createState() => _PackManBoardState();
}

class _PackManBoardState extends State<PackManBoard> {
  @override
  void didUpdateWidget(covariant PackManBoard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only triggers when moving into the END cell
    if (widget.pacmanPosition == widget.startAndEnding[1] &&
        oldWidget.pacmanPosition != widget.pacmanPosition) {
      Future.microtask(() {
        if (mounted) {
          showEndingDialog(context);
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    double cellSize = MediaQuery.of(context).size.width / widget.numberInRow;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: cellSize * widget.rows,
        child: Stack(
          children: [
            // Maze Grid
            for (
              int index = 0;
              index < widget.numberInRow * widget.rows;
              index++
            )
              Positioned(
                left: (index % widget.numberInRow) * cellSize,
                top: (index ~/ widget.numberInRow) * cellSize,
                width: cellSize,
                height: cellSize,
                child: Container(
                  decoration: BoxDecoration(
                    color: 
                    widget.startAndEnding.contains(index)
                    ? Colors.green
                    : widget.boardData.contains(index)
                        ? const Color(0xFF0D0D0F)
                        : const Color(0xFF111113),

                    gradient: widget.boardData.contains(index)
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF3A3A40),
                              Color(0xFF1C1C1E),
                              Color(0xFF000000),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : null,

                    borderRadius: BorderRadius.circular(
                      widget.boardData.contains(index) ? 10 : 4,
                    ),

                    boxShadow: widget.boardData.contains(index)
                        ? [
                            // Top highlight
                            BoxShadow(
                              color: Colors.white12,
                              offset: Offset(-2, -2),
                              blurRadius: 4,
                            ),

                            // Inner glossy bevel
                            BoxShadow(
                              color: Colors.white10,
                              offset: Offset(0, -1),
                              blurRadius: 1,
                              spreadRadius: -2,
                            ),

                            // Bottom depth shadow
                            BoxShadow(
                              color: Colors.black87,
                              offset: Offset(4, 6),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],

                    border: widget.boardData.contains(index)
                        ? Border.all(color: const Color(0xFF4A4A50), width: 1.2)
                        : Border.all(color: Colors.transparent),
                  ),
                  child: Ball(
                    isPacman: false,
                    isWall: widget.boardData.contains(index),
                    turtlePositions: widget.turtlePositions,
                  ),
                ),
              ),

            // PAC-MAN (turtle)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              left: (widget.pacmanPosition % widget.numberInRow) * cellSize,
              top: (widget.pacmanPosition ~/ widget.numberInRow) * cellSize,
              width: cellSize,
              height: cellSize,
              child: Ball(
                isPacman: true,
                isWall: false,
                turtlePositions: widget.turtlePositions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FIXED DIALOG FUNCTION — SAFE FOR PROVIDER + SAFE CONTEXT
  void showEndingDialog(BuildContext context) {
    final maze = Provider.of<MazeGeneratorLogicProvider>(
      context,
      listen: false,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: const Text("You reached the end!"),
          actions: [
            TextButton(
              onPressed: () async {
                await maze.resetGame();
                if (mounted) Navigator.pop(dialogContext);
              },
              child: const Text("Play Again"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
