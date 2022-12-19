import 'dart:io';
import 'dart:math';

List<String> input = [];

class LightGrid {
  int m, n;
  List<List<int>> items;
  LightGrid(this.m, this.n, this.items);
  factory LightGrid.generate(int m, int n) {
    List<List<int>> _items = [];
    for (int y = 0; y < n; y++) {
      _items.add(List.generate(m, (index) => 0));
    }
    return LightGrid(m, n, _items);
  }

  switchLights(int on, Point start, Point end, int part) {
    for (int y = start.y.toInt(); y <= end.y.toInt() && y < n; y++) {
      for (int x = start.x.toInt(); x <= end.x.toInt() && x < m; x++) {
         if(part == 1) items[y][x] = on;
         if(part == 2) items[y][x] = (items[y][x] + on).clamp(0, double.infinity).toInt();
      }
    }
  }

  toggleLights(Point start, Point end, int part) {
    for (int y = start.y.toInt(); y <= end.y.toInt() && y < n; y++) {
      for (int x = start.x.toInt(); x <= end.x.toInt() && x < m; x++) {
        if(part == 1) items[y][x] = (items[y][x] == 1 ? 0 : 1);
        if(part == 2) items[y][x] = (items[y][x] + 2).clamp(0, double.infinity).toInt();
      }
    }
  }

  printGrid() {
    StringBuffer _buffer = StringBuffer();
    for (int y = 0; y < n; y++) {
      _buffer.write("${items[y]}\n");
    }
    print(_buffer.toString());
  }
}

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  input = File('2015/day-6/advent15-06-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  // LightGrid _grid = LightGrid.generate(10, 10);
  // _grid.switchLights(true, Point(0, 0), Point(2, 2));
  // _grid.toggleLights(Point(0, 0), Point(2, 2));
  // _grid.printGrid();

  LightGrid _grid = LightGrid.generate(1000, 1000);
  input.forEach((element) {
    String instruction = element.replaceAll(" through ", ",");
    if (instruction.startsWith("toggle ")) {
      List<int> points = instruction.replaceAll("toggle ", "").split(",").map((e) => int.parse(e)).toList();
      _grid.toggleLights(Point(points[0], points[1]), Point(points[2], points[3]), 1);
    }
    if (instruction.startsWith("turn on ")) {
      List<int> points = instruction.replaceAll("turn on ", "").split(",").map((e) => int.parse(e)).toList();
      _grid.switchLights(1, Point(points[0], points[1]), Point(points[2], points[3]), 1);
    }
    if (instruction.startsWith("turn off ")) {
      List<int> points = instruction.replaceAll("turn off ", "").split(",").map((e) => int.parse(e)).toList();
      _grid.switchLights(0, Point(points[0], points[1]), Point(points[2], points[3]), 1);
    }
  });

  print("Solution one: ${_grid.items.fold<List>(_grid.items[0], (previousValue, element) => previousValue + element).where((e) => e == 1).toList().length}");
}

void solutionTwo() {
  // LightGrid _grid = LightGrid.generate(10, 10);
  // _grid.switchLights(true, Point(0, 0), Point(2, 2));
  // _grid.toggleLights(Point(0, 0), Point(2, 2));
  // _grid.printGrid();

  LightGrid _grid = LightGrid.generate(1000, 1000);
  input.forEach((element) {
    String instruction = element.replaceAll(" through ", ",");
    if (instruction.startsWith("toggle ")) {
      List<int> points = instruction.replaceAll("toggle ", "").split(",").map((e) => int.parse(e)).toList();
      _grid.toggleLights(Point(points[0], points[1]), Point(points[2], points[3]), 2);
    }
    if (instruction.startsWith("turn on ")) {
      List<int> points = instruction.replaceAll("turn on ", "").split(",").map((e) => int.parse(e)).toList();
      _grid.switchLights(1, Point(points[0], points[1]), Point(points[2], points[3]), 2);
    }
    if (instruction.startsWith("turn off ")) {
      List<int> points = instruction.replaceAll("turn off ", "").split(",").map((e) => int.parse(e)).toList();
      _grid.switchLights(-1, Point(points[0], points[1]), Point(points[2], points[3]), 2);
    }
  });

  print("Solution two: ${_grid.items.fold<List<int>>(_grid.items[0], (previousValue, element) => previousValue + element).toList().reduce(((value, element) => value + element))}");
}
