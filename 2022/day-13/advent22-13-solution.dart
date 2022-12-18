import 'dart:collection';
import 'dart:io';
import 'dart:math';

List<String> _input = [];
List<List<dynamic>> _grid = [];
void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-13/advent22-13-example.txt').readAsStringSync().split("\n\n");
}

void solutionOne() {
  List<int> validPairIndexes = [];
  for (int p = 0; p < _input.length; p++) {
    _input[p].split("\n").forEach((element) {
      print(element.split(","));
    });

    // _pair.forEach((element) {
    //   element.forEach((se){
    //     print(se);
    //   });
    // });
  }
  print(validPairIndexes);
}

void solutionTwo() {}
