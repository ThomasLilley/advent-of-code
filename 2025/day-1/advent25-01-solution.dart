import 'dart:io';

List<String> _rotations = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _rotations = File('2025/day-1/advent25-01-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  int zeroCount = 0;
  int position = 50;

  List<Rotation> rotations = _rotations.map((e) => Rotation.fromString(e)).toList();

  for (Rotation r in rotations) {
    for (int i = 0; i < r.turns; i++) {
      if (r.direction == 'L') {
        position--;
      }
      if (r.direction == 'R') {
        position++;
      }
      if (position == 100) {
        position = 0;
      }
      if (position == -1) {
        position = 99;
      }
    }
    if (position == 0) zeroCount++;
  }

  print("Solution One: ${zeroCount}");
}

void solutionTwo() {
  int zeroCount = 0;
  int position = 50;

  List<Rotation> rotations = _rotations.map((e) => Rotation.fromString(e)).toList();

  for (Rotation r in rotations) {
    for (int i = 0; i < r.turns; i++) {
      if (r.direction == 'L') {
        position--;
      }
      if (r.direction == 'R') {
        position++;
      }
      if (position == 100) {
        position = 0;
      }
      if (position == -1) {
        position = 99;
      }
      if (position == 0) {
        if (i < r.turns - 1) zeroCount++;
      }
    }
    if (position == 0) zeroCount++;
  }

  print("Solution Two: ${zeroCount}");
}

class Rotation {
  final String direction;
  final int turns;

  Rotation._internal(this.direction, this.turns);

  factory Rotation.fromString(String input) {
    String d = input[0];
    int turns = int.parse(input.substring(1));

    return Rotation._internal(d, turns);
  }

  @override
  String toString() {
    return "$direction:$turns";
  }
}
