import 'dart:io';
import 'dart:math';

List<String> input = [];
String facing = 'n';
Point blocks = Point(0, 0);
Map<Point, int> visitedMap = {Point(0, 0): 1};
Point? visitedTwice;
void main() {
  readFile();
  solutionOne();
  reset();
  solutionTwo();
}

void reset() {
  facing = 'n';
  blocks = Point(0, 0);
  visitedMap = {Point(0, 0): 1};
  visitedTwice = null;
}

void readFile() {
  input = File('2016/day-1/advent16-01-input.txt').readAsStringSync().split(", ");
}

void changeDirection(String turnDirection) {
  if (turnDirection == "R") {
    switch (facing) {
      case "n":
        facing = "e";
        break;
      case "e":
        facing = "s";
        break;
      case "s":
        facing = "w";
        break;
      case "w":
        facing = "n";
        break;
    }
  } else {
    switch (facing) {
      case "n":
        facing = "w";
        break;
      case "e":
        facing = "n";
        break;
      case "s":
        facing = "e";
        break;
      case "w":
        facing = "s";
        break;
    }
  }
}

void calculateBlocks(int length) {
  switch (facing) {
    case "n":
      blocks = Point(blocks.x, blocks.y + length);
      break;
    case "e":
      blocks = Point(blocks.x + length, blocks.y);
      break;
    case "s":
      blocks = Point(blocks.x, blocks.y - length);
      break;
    case "w":
      blocks = Point(blocks.x - length, blocks.y);
      break;
  }
}

void calculateVisited(int length) {
  for (int i = 1; i < length + 1; i++) {
    Point? newPoint;
    switch (facing) {
      case "n":
        newPoint = Point(blocks.x, blocks.y + i);
        break;
      case "e":
        newPoint = Point(blocks.x + i, blocks.y);
        break;
      case "s":
        newPoint = Point(blocks.x, blocks.y - i);
        break;
      case "w":
        newPoint = Point(blocks.x - i, blocks.y);
        break;
    }
    if (visitedMap[newPoint] != null) {
      print("point crossover at $newPoint");
      visitedMap[newPoint!] = visitedMap[newPoint]! + 1;
      visitedTwice = newPoint;
    } else {
      visitedMap.addAll({newPoint!: 1});
    }
  }
}

void solutionOne() {
  for (String direction in input) {
    changeDirection(direction[0]);
    int length = int.parse(direction.substring(1, direction.length));
    calculateBlocks(length);
    //print("Turned ${direction[0]} Moving ${length} to $blocks and facing $facing");
  }
  int distance = ((0 - blocks.x.toInt().abs()) + (0 - blocks.y.toInt().abs())).abs();
  print("distance is $distance");
}

void solutionTwo() {
  for (String direction in input) {
    changeDirection(direction[0]);
    int length = int.parse(direction.substring(1, direction.length));

    if (visitedTwice == null) {
      calculateVisited(length);
    }

    calculateBlocks(length);
    //print("Turned ${direction[0]} Moving ${length} to $blocks and facing $facing");
  }
  int distance = ((0 - visitedTwice!.x.toInt().abs()) + (0 - visitedTwice!.y.toInt().abs())).abs();
  print("distance is $distance");
}
