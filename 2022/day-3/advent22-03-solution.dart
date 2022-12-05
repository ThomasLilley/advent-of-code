import 'dart:io';

List<String> _bags = [];
List<String> _duplicates = [];
List<String> _alphabet = [];

void main() {
  readFile();
  generateAlphabet();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _bags =
      File('2022/day-3/advent22-03-input.txt').readAsStringSync().split("\n");
}

void generateAlphabet() {
  List<int> _charactersLowercase =
      new List<int>.generate(26, (int index) => index + 97);
  List<int> _charactersUppercase =
      new List<int>.generate(26, (int index) => index + 65);
  List<int> _characters = _charactersLowercase + _charactersUppercase;
  _alphabet = String.fromCharCodes(_characters).split('');
}

void solutionOne() {
   int _score = 0;
  _bags.forEach((bag) {
    List<String> _compartmentOne = bag.substring(0, bag.length ~/ 2).split('');
    for (int i = 0; i < _compartmentOne.length; i++) {
      if (bag
          .substring(bag.length ~/ 2, bag.length)
          .contains(_compartmentOne[i])) {
        _duplicates.add(_compartmentOne[i]);
         _score += (_alphabet.indexOf(_compartmentOne[i]) + 1);
        break;
      }
    }
  });

  print("Solution one: $_score");
}

void solutionTwo() {
  int _score = 0;

  for (int i = 0; i < _bags.length; i += 3) {
    List<String> _bag =  _bags[i].split('');
   _bag.removeWhere((element) => !_bags[i+1].contains(element) || !_bags[i+2].contains(element));
    _score += (_alphabet.indexOf(_bag.first) + 1);
  }

  print("Solution two: $_score");
}
