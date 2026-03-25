import 'package:flutter/material.dart';
import 'package:pacman/home/ball.dart';

class PackManBoard extends StatefulWidget {
  final int pacmanPosition;
  final int numberInRow;
  final int rows;
  final List<int> startAndEnding;
  final List<int> boardData;
  final String turtlePositons;

  const PackManBoard({
    super.key,
    required this.pacmanPosition,
    required this.numberInRow,
    required this.rows,
    required this.boardData,
    required this.startAndEnding,
    required this.turtlePositons,
  });

  @override
  State<PackManBoard> createState() => _PackManBoardState();
}

class _PackManBoardState extends State<PackManBoard> {
  bool popupShown = false;
  @override
  void didUpdateWidget(PackManBoard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!popupShown && widget.pacmanPosition == widget.startAndEnding[1]) {
      popupShown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showBottomPopup(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.numberInRow * widget.rows,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.numberInRow,
        ),
        itemBuilder: (context, index) {
          final bool isWall = widget.boardData.contains(index);
          final bool isPacman = index == widget.pacmanPosition;
          final bool isStartAndEnding = widget.startAndEnding.contains(index);
          return Container(
            decoration: BoxDecoration(
              color: isWall
                  ? Colors.blue[900]
                  : isStartAndEnding
                  ? Colors.green
                  : Colors.black,
              borderRadius: BorderRadius.circular(isWall ? 4 : 2),
              boxShadow: isWall
                  ? [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: 0.5),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Ball(isPacman: isPacman, isWall: isWall, turtlePositions: widget.turtlePositons,),
          );
        },
      ),
    );
  }

  void _showBottomPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Text(
              "Pac-Man reached the spot!",
              style: TextStyle(color: Colors.yellow, fontSize: 22),
            ),
          ),
        );
      },
    );
  }
}
