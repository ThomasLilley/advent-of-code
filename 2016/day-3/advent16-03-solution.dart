import 'dart:io';

List<String> input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  input = File('2016/day-3/advent16-03-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  int valid = 0;
  for (var tri in input) {
    if (tri.startsWith('    ')) tri = tri.substring(4, tri.length);
    if (tri.startsWith('   ')) tri = tri.substring(3, tri.length);
    if (tri.startsWith('  ')) tri = tri.substring(2, tri.length);
    tri = tri.replaceAll(RegExp(r'\ {3,6}'), '  ');
    List<int> sides = tri.split('  ').map((e) {
      return int.parse(e);
    }).toList()
      ..sort();
    if (sides[0] + sides[1] > sides[2]) valid++;
  }
  print("Solution 1: $valid");
}

void solutionTwo() {
  int valid = 0;
  List<int> numbers = [];
  for (int i = 0; i < input.length; i++) {
    var tri = input[i];
    if (tri.startsWith('    ')) tri = tri.substring(4, tri.length);
    if (tri.startsWith('   ')) tri = tri.substring(3, tri.length);
    if (tri.startsWith('  ')) tri = tri.substring(2, tri.length);
    tri = tri.replaceAll(RegExp(r'\ {3,6}'), '  ');
    numbers.addAll(tri.split('  ').map((e) {
      return int.parse(e);
    }).toList());
  }

  for (int i = 0; i < numbers.length; i += 9) {
    List<List<int>> groups = [
      [numbers[i], numbers[i + 3], numbers[i + 6]],
      [numbers[i + 1], numbers[i + 4], numbers[i + 7]],
      [numbers[i + 2], numbers[i + 5], numbers[i + 8]]
    ];
    for (var group in groups) {
      group.sort();
      if (group[0] + group[1] > group[2]) valid++;
    }
  }

  print("Solution 2: $valid");
}
