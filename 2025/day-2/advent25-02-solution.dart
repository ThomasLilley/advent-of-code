import 'dart:io';
import 'dart:math';

List<String> _input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2025/day-2/advent25-02-input.txt').readAsStringSync().split(",");
}

void solutionOne() {
  List<int> invalidCodes = [];

  List<RangeObj> ranges = _input.map((e) => RangeObj.fromString(e)).toList();

  for (RangeObj r in ranges) {
    for (int i = r.start; i < r.end + 1; i++) {
      String str = i.toString();
      int length = str.length;
      if (length.isOdd) continue;

      if (str.substring(0, length ~/ 2) == str.substring((length ~/ 2))) {
        print("Invalid! $str");
        invalidCodes.add(i);
      }
    }
  }

  print("Solution One: ${invalidCodes.reduce((a, b) => a + b)}");
}

void solutionTwo() {
  List<int> invalidCodes = [];

  List<RangeObj> ranges = _input.map((e) => RangeObj.fromString(e)).toList();

  for (RangeObj r in ranges) {
    for (int i = r.start; i < r.end + 1; i++) {
      String str = i.toString();
      int length = str.length;
      if (i.toString().substring(0, length ~/ 2) == i.toString().substring((length ~/ 2))) {
        print("Invalid! $i");
        invalidCodes.add(i);
        continue;
      }

      for (int j = length - 1; j > 0; j--) {
        if (length % j != 0) continue;
        final List<String> splits = [];
        for (int k = 0; k < length + 1 - j; k += j) {
          splits.add(str.substring(k, k + j));
        }

        if (splits.every((e) => e == splits.first)) {
          print("Invalid! $i => $splits");
          invalidCodes.add(i);
          continue;
        }
      }
    }
  }

  print("Solution Two: ${invalidCodes.reduce((a, b) => a + b)}");
}

class RangeObj {
  final int start;
  final int end;

  RangeObj._internal(this.start, this.end);

  factory RangeObj.fromString(String input) {
    final range = input.split('-');

    return RangeObj._internal(int.parse(range.first), int.parse(range.last));
  }

  @override
  String toString() {
    return "$start-$end";
  }
}
