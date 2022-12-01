import 'dart:io';

List<String> input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  input = File('2015/day-1/advent15-01-input.txt').readAsStringSync().split("");
}

void solutionOne() {
  int floors = 0;
  input.forEach((element) {
    element == "(" ? floors++ : floors--;
  });
  print("Solution one: $floors");
}

void solutionTwo() {
  int floors = 0;
  for (int i = 0; i < input.length; i++) {
    input[i] == "(" ? floors++ : floors--;
    if (floors == -1) {
      print("Solution two: ${i + 1}");
      break;
    }
  }
}
