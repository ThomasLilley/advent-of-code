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
  for(var tri in input){
    if(tri.startsWith('    ')) tri = tri.substring(4, tri.length);
    if(tri.startsWith('   ')) tri = tri.substring(3, tri.length);
    if(tri.startsWith('  ')) tri = tri.substring(2, tri.length);
    tri = tri.replaceAll(RegExp(r'\ {3,6}'), '  ');
    List<int> sides = tri.split('  ').map((e) {
      return int.parse(e);
    }).toList()..sort();
    if(sides[0] + sides[1] > sides[2]) valid++;
  }
  print("Solution 1: $valid");
 }

void solutionTwo() {
}
