import 'dart:collection';
import 'dart:io';
import 'dart:math';

List<String> _input = [];
List<List<dynamic>> _grid = [];
void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-12/advent22-12-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  int height = _input.length, width = _input[0].length;
  List start = [], end = [];
  for (int y = 0; y < height; y++) {
    List<String> _line = _input[y].split("");
    List<int> _lineValues = List.generate(_line.length, (index) => 0);
    for (int x = 0; x < width; x++) {
      if (_line[x] == "S") {
        _lineValues[x] = "a".codeUnitAt(0) - 97;
        start = [y, x];
      } else if (_line[x] == "E") {
        _lineValues[x] = "z".codeUnitAt(0) - 97;
        end = [y, x];
      } else {
        _lineValues[x] = "${_line[x]}".codeUnitAt(0) - 97;
      }
    }
    _grid.add(_lineValues);
  }

  print("Solution one: ${smallestPath(start, end)}");
}

void solutionTwo() {
  int height = _input.length, width = _input[0].length;
  List starts = [], end = [];
  for (int y = 0; y < height; y++) {
    List<String> _line = _input[y].split("");
    List<int> _lineValues = List.generate(_line.length, (index) => 0);
    for (int x = 0; x < width; x++) {
      if (_line[x] == "S" || _line[x] == "a") {
        _lineValues[x] = "a".codeUnitAt(0) - 97;
        starts.add([y, x]);
      } else if (_line[x] == "E") {
        _lineValues[x] = "z".codeUnitAt(0) - 97;
        end = [y, x];
      } else {
        _lineValues[x] = "${_line[x]}".codeUnitAt(0) - 97;
      }
    }
    _grid.add(_lineValues);
  }

  List<int> routes = [];
  for (int s = 0; s < starts.length; s++) {
    var _result = smallestPath(starts[s], end);
    if(_result!=null)routes.add(_result);
  }
  print("Solution two: ${routes.reduce(min)}");
}

dynamic smallestPath(start, end) {
  Queue _heap = Queue();
  _heap.addLast([start[0], start[1], 0]);
  List<dynamic> _seen = ["${start[0]},${start[1]}"];
  while (_heap.length > 0) {
    List<dynamic> _element = _heap.removeLast();
    int x = _element[0], y = _element[1], dist = _element[2];
    if (x == end[0] && y == end[1]) {
      return _element[2];
    }

    var directions = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ];
    for (int i = 0; i < 4; i++) {
      int dx = directions[i][0], dy = directions[i][1];
      int x2 = x + dx, y2 = y + dy;

      if (0 <= x2 && x2 < _grid.length && 0 <= y2 && y2 < _grid[0].length && !_seen.contains("${x2},${y2}") && _grid[x2][y2] <= _grid[x][y] + 1) {
        _seen.add("${x2},${y2}");
        _heap.addFirst([x2, y2, dist + 1]);
        //print(_heap);
      }
    }
  }
}
