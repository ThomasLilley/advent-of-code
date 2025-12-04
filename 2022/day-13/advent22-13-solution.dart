import 'dart:io';

List<String> _input = [];
List<List<dynamic>> _grid = [];
void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-13/advent22-13-input.txt').readAsStringSync().split("\n\n");
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
            _currentList.add(int.parse(letter));
            break;
        }
      }

      _pairs.add(_currentList);
    });
    allPairs.add(_pairs);
  }

  List<int> _validPairs = [];
  for (int pair = 0; pair < allPairs.length; pair++) {
    //print("Comparing: ${allPairs[pair]}");
    List pair1 = allPairs[pair].first, pair2 = allPairs[pair].last;
    var valid = comparePairs(pair1, pair2);
    if (valid == 1) _validPairs.add(pair + 1);
  }
  print(_validPairs);
  print(_validPairs.reduce((value, element) => value + element));
}

comparePairs(List pair1, List pair2) {
  if (pair1.length < pair2.length) return 1;
  return 0;
}

void solutionTwo() {}
