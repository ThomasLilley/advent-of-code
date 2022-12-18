import 'dart:io';

List<String> input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  input = File('2015/day-5/advent15-05-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  List<String> _goodStrings = [];

  for (String item in input) {
    if (item.contains(RegExp(r'/(ab)|(cd)|(pq)|(or)|(xy)/g'))) continue;
    if (RegExp(r'([a-z])\1{1,}').hasMatch(item) && RegExp(r'[aeiou]').allMatches(item).length >= 3) _goodStrings.add(item);
  }
  print("Solution one: ${_goodStrings.length}");
}

void solutionTwo() {
  List<String> _goodStrings = [];

  for (String item in input) {
    if (RegExp(r'([a-z]{2}).*\1{1}').hasMatch(item) 
    && RegExp(r'([a-z])\1{0}.\1{1}').hasMatch(item)) {
      _goodStrings.add(item);
    }
  }
  print("Solution two: ${_goodStrings.length}");
}
