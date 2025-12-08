import 'dart:io';
import 'dart:math';

List<String> _input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2025/day-4/advent25-04-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  List<List<String>> map = _input.map((e) => e.split('').toList()).toList();

  List<Point> matrix = [Point(-1, -1), Point(0, -1), Point(1, -1), Point(-1, 0), Point(1, 0), Point(-1, 1), Point(0, 1), Point(1, 1)];

  int reachableRolls = 0;

  for (int row = 0; row < map.length; row++) {
    for (int column = 0; column < map[row].length; column++) {
      if (map[row][column] != '@') continue;
      int rollCount = 0;

      for (final point in matrix) {
        if (row + point.x < 0 || row + point.x > map.length - 1) {
          continue;
        }

        if (column + point.y < 0 || column + point.y > map[row].length - 1) {
          continue;
        }

        if (map[row + point.x.toInt()][column + point.y.toInt()] == '@') {
          rollCount++;
        }
      }

      if (rollCount < 4) {
        reachableRolls++;
      }
    }
  }

  print("Solution One: $reachableRolls");
}

void solutionTwo() {
  List<List<String>> map = _input.map((e) => e.split('').toList()).toList();

  List<Point> matrix = [Point(-1, -1), Point(0, -1), Point(1, -1), Point(-1, 0), Point(1, 0), Point(-1, 1), Point(0, 1), Point(1, 1)];

  int reachableRolls = 0;
  int rollsThisRound = 1;

  do {
    rollsThisRound = 0;
    for (int row = 0; row < map.length; row++) {
      for (int column = 0; column < map[row].length; column++) {
        if (map[row][column] != '@') continue;
        int rollCount = 0;

        for (final point in matrix) {
          if (row + point.x < 0 || row + point.x > map.length - 1) {
            continue;
          }

          if (column + point.y < 0 || column + point.y > map[row].length - 1) {
            continue;
          }

          if (map[row + point.x.toInt()][column + point.y.toInt()] == '@') {
            rollCount++;
          }
        }

        if (rollCount < 4) {
          reachableRolls++;
          rollsThisRound++;
          map[row][column] = 'x';
        }
      }
    }
    print('this round rolls $rollsThisRound');
  } while (rollsThisRound > 0);
  print("Solution Two $reachableRolls");
}
