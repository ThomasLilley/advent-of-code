import 'dart:io';
import 'dart:math';

List<String> _input = [];
List<List<int>> _grid = [];
Map<Point, bool> _visible = {};

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-8/advent22-08-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  _input.forEach((element) {
    _grid.add(element.split("").map((e) => int.parse(e)).toList());
  });

  for (int col = 0; col < _grid.length; col++) {
    for (int row = 0; row < _grid[col].length; row++) {
      _visible.addAll({Point(col, row): false});
    }
  }

  for (int col = 0; col < _grid.length; col++) {
    Map<String, int> _highestSeen = {
      "left": 0,
      "right": 0,
      "up": 0,
      "down": 0,
    };
    int row = 0;
    for (row; row < _grid[col].length; row++) {
      ///Fill Edges
      if (col == 0 || col == _grid.length - 1 || row == 0 || row == _grid[row].length - 1) {
        _visible.update(Point(col, row), (v) => true);
      }

      ///Right Sweep
      if (_grid[col][row] > _highestSeen["right"]!) {
        _highestSeen["right"] = _grid[col][row];
        _visible.update(Point(col, row), (v) => true);
      }

      ///Left Sweep
      if (_grid[col][_grid[row].length - 1 - row] > _highestSeen["left"]!) {
        _highestSeen["left"] = _grid[col][_grid[row].length - 1 - row];
        _visible.update(Point(col, _grid[row].length - 1 - row), (v) => true);
      }
    }

     for (int i = 0; i < _grid.length; i++) {

      ///down Sweep
      if (_grid[i][col] > _highestSeen["down"]!){
        _highestSeen["down"] = _grid[i][col];
         _visible.update(Point(i, col), (v) => true);
      } 

      ///up Sweep
      if (_grid[_grid.length - 1 - i][col] > _highestSeen["up"]!){
        _highestSeen["up"] = _grid[_grid.length - 1 - i][col];
          _visible.update(Point(_grid.length - 1 - i, col), (v) => true);
      } 
  }
  }



  print(_visible.values.length);
  print(_visible.values.where((element) => element == true).toList().length);
}
void solutionTwo() {}
