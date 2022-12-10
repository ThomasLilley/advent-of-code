import 'dart:ffi';
import 'dart:io';

List<String> _input = [];
List<int> _currentHeadPos = [0, 0];
List<int> _currentTailPos = [0, 0];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-9/advent22-09-example.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  Grid _grid = Grid.generate(10, 10);

  _input.forEach((element) {
    List<String> _instruction = element.split(" ");
    String _direction = _instruction.first;
    int _length = int.parse(_instruction.last);

    for (int i = 0; i < _length; i++) {
      switch (_instruction.first) {
        case "L":
          stdout.writeln("L");
          _currentHeadPos[0]--;
          break;
        case "R":
          stdout.writeln("R");
          _currentHeadPos[0]++;
          break;
        case "U":
          stdout.writeln("U");
          _currentHeadPos[1]++;
          break;
        case "D":
          stdout.writeln("D");
          _currentHeadPos[1]--;
          break;
      }
      _grid.grid[_grid.indexOf(_currentHeadPos[0], _currentHeadPos[1])].headVisited++;
      
      print(_grid);
    }
  });
}

void solutionTwo() {}

class Grid {
  int m;
  int n;
  List<GridElement> grid;
  Grid(this.m, this.n, this.grid);
  factory Grid.generate(int m, int n) {
    List<GridElement> _grid = [];
    for (int y = 0; y < m; y++) {
      for (int x = 0; x < n; x++) {
        _grid.add(GridElement(x, y));
      }
    }
    return Grid(m, n, _grid);
  }

  GridElement getElement(int x, int y) {
    return grid[(x) + (y * n)];
  }

  int indexOf(x, y){
    return (x) + (y * n);
  }

  void setElement(int x, int y, GridElement element) {
    grid[(x) + (y * n)] = element;
  }

  @override
  String toString({bool withDivider = false}) {
    StringBuffer buffer = StringBuffer();
    List<List<GridElement>> _rows = [];
    for (int i = 0; i < grid.length; i += n) {
      _rows.insert(0, this.grid.sublist(i, i + n));
      //buffer.write("${this.grid[i]} ${withDivider ? "," : ""}${(i + 1) % n == 0 ? "\n" : ""}");
    }
    _rows.forEach((row) {
      row.forEach((element) {
        buffer.write("$element ");
      });
      buffer.write("\n");
    });
    return buffer.toString();
  }
}

class GridElement {
  int x;
  int y;
  int headVisited;
  int tailVisited;
  GridElement(this.x, this.y, {this.headVisited = 0, this.tailVisited = 0});

  @override
  String toString() {
    if (_currentHeadPos[0] == x && _currentHeadPos[1] == y &&  _currentTailPos[0] == x && _currentTailPos[1] == y) return "B";
    if (_currentHeadPos[0] == x && _currentHeadPos[1] == y) return "H";
    if (_currentTailPos[0] == x && _currentTailPos[1] == y) return "T";
    if (tailVisited > 0) return "#";
    if(headVisited > 0) return "%";
    return ".";
  }
}
