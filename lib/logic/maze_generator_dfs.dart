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