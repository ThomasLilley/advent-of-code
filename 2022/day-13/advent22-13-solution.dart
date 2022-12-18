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
  List allPairs = [];

  for (int p = 0; p < _input.length; p++) {
    List _pairs = [];
    _input[p].split("\n").forEach((element) {
      List _currentList = [];
      List single = element.split("");
      for (int i = 0; i < single.length; i++) {
        String letter = single[i];
        switch (letter) {
          case "[":
            if (i == 0) continue;
            _pairs.add(_currentList);
            List newList = [];
            _currentList.add(newList);
            _currentList = newList;
            break;
          case "]":
            if (i == single.length - 1) continue;
            _currentList = _pairs.removeLast();
            break;
          case " ":
          case ",":
            continue;
          default:
            _currentList.add(letter);
            break;
        }
      }

      _pairs.add(_currentList);
    });
    allPairs.add(_pairs);
  }

  allPairs.forEach((element) {
    print("${element.first} & ${element.last}");
  });
}

void solutionTwo() {}
