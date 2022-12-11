import 'dart:io';
import 'dart:math';

List<String> _input = [];

void main() {
  readFile();
  print("Solution one: ${moveRope(2)}");
  print("Solution two: ${moveRope(10)}");
}

void readFile() {
  _input = File('2022/day-9/advent22-09-input.txt').readAsStringSync().split("\n");
}

int moveRope(int knots) {
  var touched = {Point(0, 0)};
  var rope = List.generate(knots, (i) => Point(0, 0));
  _input.forEach((element) {
    List<String> _instruction = element.split(" ");
    String _direction = _instruction.first;
    int _length = int.parse(_instruction.last);

    for (int i = 0; i < _length; i++) {
      switch (_direction) {
        case "L":
          rope.first = Point(rope.first.x - 1, rope.first.y);
          break;
        case "R":
          rope.first = Point(rope.first.x + 1, rope.first.y);
          break;
        case "U":
          rope.first = Point(rope.first.x, rope.first.y + 1);
          break;
        case "D":
          rope.first = Point(rope.first.x, rope.first.y - 1);
          break;
      }

      for (var j = 1; j <= knots - 1; j++) {
        var x = rope[j - 1].x - rope[j].x;
        var y = rope[j - 1].y - rope[j].y;
        if (max(x.abs(), y.abs()) > 1) {
          if (x.abs() >= 1) {
            if (x < 0) {
              rope[j] = Point(rope[j].x - 1, rope[j].y);
            } else {
              rope[j] = Point(rope[j].x + 1, rope[j].y);
            }
          }
          if (y.abs() >= 1) {
            if (y < 0) {
              rope[j] = Point(rope[j].x, rope[j].y - 1);
            } else {
              rope[j] = Point(rope[j].x, rope[j].y + 1);
            }
          }
        }
      }
      touched.add(rope.last);
    }
  });
  return touched.length;
}
