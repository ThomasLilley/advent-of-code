import 'dart:io';
import 'dart:math';

List<String> _input = [];
List<List<Tree>> _grid = [];

class Tree {
  int x;
  int y;
  int height;
  bool visible;
  int scoreL;
  int scoreR;
  int scoreU;
  int scoreD;

  bool? isEdge;
  Tree(
    this.x,
    this.y,
    this.height, {
    this.visible = false,
    this.scoreL = 0,
    this.scoreR = 0,
    this.scoreU = 0,
    this.scoreD = 0,
    this.isEdge = false,
  });

  int score() => scoreL * scoreR * scoreU * scoreD;
  String scoreToString() => "(${score()}) L:$scoreL R:$scoreR U:$scoreU D:$scoreD";

  @override
  String toString() {
    return "($x,$y) h:$height";
  }
}

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-8/advent22-08-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  for (int i = 0; i < _input.length; i++) {
    int _count = 0;
    List<Tree> _row = _input[i].split("").map((e) {
      Tree _tree = Tree(_count, i, int.parse(e));
      _count++;
      return _tree;
    }).toList();
    _grid.add(_row);
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
        _grid[col][row].visible = true;
        _grid[col][row].isEdge = true;
      }

      ///Right Sweep
      if (_grid[col][row].height > _highestSeen["right"]!) {
        _highestSeen["right"] = _grid[col][row].height;
        _grid[col][row].visible = true;
      }

      ///Left Sweep
      if (_grid[col][_grid[row].length - 1 - row].height > _highestSeen["left"]!) {
        _highestSeen["left"] = _grid[col][_grid[row].length - 1 - row].height;
        _grid[col][_grid[row].length - 1 - row].visible = true;
      }
    }

    for (int i = 0; i < _grid.length; i++) {
      ///Down Sweep
      if (_grid[i][col].height > _highestSeen["down"]!) {
        _highestSeen["down"] = _grid[i][col].height;
        _grid[i][col].visible = true;
      }

      ///Up Sweep
      if (_grid[_grid.length - 1 - i][col].height > _highestSeen["up"]!) {
        _highestSeen["up"] = _grid[_grid.length - 1 - i][col].height;
        _grid[_grid.length - 1 - i][col].visible = true;
      }
    }
  }

  int _length = 0;
  int _visibleCount = 0;
  _grid.forEach((element) {
    _length += element.length;
    _visibleCount += element.where((element) => element.visible == true).toList().length;
  });

  print("Solution one: $_visibleCount");
}

void solutionTwo() {
  List<Tree> _allTrees = [];
  _grid.forEach((element) {
    _allTrees.addAll(element);
  });

  for (int e = 0; e < _allTrees.length; e++) {
    Tree element = _allTrees[e];
    //looking left

    ///(y,x) x0, x1, x2
    /// y0  0,0  0,1 0,2
    /// y1  1,0  1,1 1,2
    /// y2  2,0  2,1 2,2
    /// _grid[y][x];

    //looking left
    for (int x = element.x - 1; x > -1; x--) {
      if (element.height > _grid[element.y][x].height) {
        element.scoreL++;
      } else if (element.height <= _grid[element.y][x].height) {
        element.scoreL++;
        break;
      } else {
        break;
      }
    }
    //looking right
    for (int x = element.x + 1; x < _grid[element.y].length; x++) {
      if (element.height > _grid[element.y][x].height) {
        element.scoreR++;
      } else if (element.height <= _grid[element.y][x].height) {
        element.scoreR++;
        break;
      } else {
        break;
      }
    }
    //looking up
    for (int y = element.y - 1; y > -1; y--) {
      if (element.height > _grid[y][element.x].height) {
        element.scoreU++;
      } else if (element.height <= _grid[y][element.x].height) {
        element.scoreU++;
        break;
      } else {
        break;
      }
    }

    //looking down
    for (int y = element.y + 1; y < _grid.length; y++) {
      if (element.height > _grid[y][element.x].height) {
        element.scoreD++;
      } else if (element.height <= _grid[y][element.x].height) {
        element.scoreD++;
        break;
      } else {
        break;
      }
    }
    _allTrees[e] = element;
  }

  Tree _winner = _allTrees.reduce((value, element) => (value.score() > element.score()) ? value : element);
  print("Solution two: ${_winner.score()}");
}
