import 'dart:io';
import 'dart:math';

List<String> input = [];

Map<Point, int> keypad = {
  Point(-1, 1): 1,
  Point(0, 1): 2,
  Point(1, 1): 3,
  Point(-1, 0): 4,
  Point(0, 0): 5,
  Point(1, 0): 6,
  Point(-1, -1): 7,
  Point(0, -1): 8,
  Point(1, -1): 9,
};

Map<Point, String> keypad2 = {
  Point(0, 2): "1",
  Point(-1, 1): "2",
  Point(0, 1): "3",
  Point(1, 1): "4",
  Point(-2, 0): "5",
  Point(-1, 0): "6",
  Point(0, 0): "7",
  Point(1, 0): "8",
  Point(2, 0): "9",
  Point(-1, -1): "A",
  Point(0, -1): "B",
  Point(1, -1): "C",
  Point(0, -2): "D",
};

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  input = File('2016/day-2/advent16-02-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  String sequence = '';
  Point currentPos = Point(0, 0);
  for (var stepsList in input) {
    List<String> steps = stepsList.split('');
    for (String step in steps) {
      switch (step) {
        case "R":
          if (currentPos.x < 1) {
            currentPos = Point(currentPos.x + 1, currentPos.y);
          }
          break;
        case "L":
          if (currentPos.x > -1) {
            currentPos = Point(currentPos.x - 1, currentPos.y);
          }
          break;
        case "U":
          if (currentPos.y < 1) {
            currentPos = Point(currentPos.x, currentPos.y + 1);
          }
          break;
        case "D":
          if (currentPos.y > -1) {
            currentPos = Point(currentPos.x, currentPos.y - 1);
          }
          break;
      }
    }
    sequence = sequence + "${keypad[currentPos]}";
  }
  print(sequence);
}

void solutionTwo() {
  String sequence = '';
  Point currentPos = Point(-2, 0);
  for (var stepsList in input) {
    List<String> steps = stepsList.split('');
    for (String step in steps) {
      switch (step) {
        case "R":
         if (currentPos.y == 0 && currentPos.x == 1) {
            currentPos = Point(2, currentPos.y);
          } else if (currentPos.x < 1 && (currentPos.y < 2 && currentPos.y > -2)) {
            currentPos = Point(currentPos.x + 1, currentPos.y);
          }
          break;
        case "L":
          if (currentPos.y == 0 && currentPos.x == -1) {
            currentPos = Point(-2, currentPos.y);
          } else if (currentPos.x > -1 && (currentPos.y < 2 && currentPos.y > -2)) {
            currentPos = Point(currentPos.x - 1, currentPos.y);
          }

          break;
        case "U":
          if (currentPos.x == 0 && currentPos.y == 1) {
            currentPos = Point(currentPos.x, 2);
          } else if (currentPos.y < 1 && (currentPos.x < 2 && currentPos.x > -2)) {
            currentPos = Point(currentPos.x, currentPos.y + 1);
          }

          break;
        case "D":
          if (currentPos.x == 0 && currentPos.y == -1) {
            currentPos = Point(currentPos.x, -2);
          } else if (currentPos.y > -1 && (currentPos.x < 2 && currentPos.x > -2)) {
            currentPos = Point(currentPos.x, currentPos.y - 1);
          }

          break;
      }
    }
    sequence = sequence + "${keypad2[currentPos]}";
  }
  print(sequence);
}