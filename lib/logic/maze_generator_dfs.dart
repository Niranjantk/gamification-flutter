import 'dart:async';
import 'package:flutter/material.dart';

class MazeGeneratorLogicProvider extends ChangeNotifier {
  int _numberInRows = 11;
  int _rows = 11;

  String _turtleDirection = "right";
  final List<int> _startAndEnding = [78, 20];
  int _pacmanPositions = 78;

  List<int> _boardData = [];

  // ---------------- TIMER ----------------
  int _timer = 60;                    // FIXED: int instead of double
  Timer? _countdownTimer;

  // CALLBACK FOR GAME OVER
  VoidCallback? onTimeOver;           // ✅ Added here

  // ---------------- SCORE & LIVES ----------------
  int _score = 0;
  int _lives = 3;

  // ------------ GETTERS ------------
  int get numberInRows => _numberInRows;
  int get rows => _rows;
  String get turtleDirection => _turtleDirection;
  int get pacmanPositions => _pacmanPositions;
  List<int> get boardData => _boardData;
  int get timer => _timer;
  int get score => _score;
  int get lives => _lives;
  List<int> get startAndEnding => _startAndEnding;

  MazeGeneratorLogicProvider() {
    _boardData = generateMaze(_rows, _numberInRows);
  }

  // -----------------------------------------------------
  // MAZE GENERATION
  // -----------------------------------------------------
  List<int> generateMaze(int rows, int cols) {
    List<List<int>> maze = List.generate(
      rows,
      (_) => List.generate(cols, (_) => 1),
    );

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

  // -----------------------------------------------------
  // MOVEMENT CONTROLS
  // -----------------------------------------------------
  void moveUp() {
    int newPos = _pacmanPositions - _numberInRows;
    if (!_boardData.contains(newPos)) {
      _pacmanPositions = newPos;
      _turtleDirection = "up";
      notifyListeners();
    }
  }

  void moveDown() {
    int newPos = _pacmanPositions + _numberInRows;
    if (!_boardData.contains(newPos)) {
      _pacmanPositions = newPos;
      _turtleDirection = "down";
      notifyListeners();
    }
  }

  void moveLeft() {
    int newPos = _pacmanPositions - 1;
    if (!_boardData.contains(newPos)) {
      _pacmanPositions = newPos;
      _turtleDirection = "left";
      notifyListeners();
    }
  }

  void moveRight() {
    int newPos = _pacmanPositions + 1;
    if (!_boardData.contains(newPos)) {
      _pacmanPositions = newPos;
      _turtleDirection = "right";
      notifyListeners();
    }
  }

  // -----------------------------------------------------
  // RESET GAME
  // -----------------------------------------------------
  Future<void> resetGame() async {
    _pacmanPositions = _startAndEnding.first;
    _turtleDirection = "right";
    _boardData = generateMaze(_rows, _numberInRows);
    notifyListeners();
  }

  void resetPacmanPosition() {
    _pacmanPositions = _startAndEnding.first;
    notifyListeners();
  }

  // -----------------------------------------------------
  // TIMER (WITH GAME OVER CALLBACK)
  // -----------------------------------------------------
  void startGameTimer() {
    _countdownTimer?.cancel(); // prevent duplicates

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timer > 0) {
        _timer--;
      } else {
        timer.cancel();

        // 🔥 Call Game Over popup
        if (onTimeOver != null) {
          onTimeOver!();
        }
      }

      notifyListeners();
    });
  }

  // SCORE
  void gameScrore() {}

  // LIVES
  void gameLives() {}
}