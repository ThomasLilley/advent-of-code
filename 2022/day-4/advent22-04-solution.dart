import 'dart:io';

List<String> _pairs = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _pairs = File('2022/day-4/advent22-04-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  int _pairCount = 0;

  _pairs.forEach((element) {
    List<String> _sections = element.split(",");
    List<int> _sectionOne = _sections.first.split("-").map((e) => int.parse(e)).toList();
    List<int> _sectionTwo = _sections.last.split("-").map((e) => int.parse(e)).toList();

    if (_sectionOne.first >= _sectionTwo.first && _sectionOne.last <= _sectionTwo.last)
      _pairCount++; //pair 1 fits into 2
    else if (_sectionTwo.first >= _sectionOne.first && _sectionTwo.last <= _sectionOne.last) _pairCount++; //pair 2 fits into 1
  });
  print("Solution one: $_pairCount");
}

void solutionTwo() {
  int _pairCount = 0;

  _pairs.forEach((element) {
    List<String> _sections = element.split(",");
    List<int> _sectionOne = _sections.first.split("-").map((e) => int.parse(e)).toList();
    List<int> _sectionTwo = _sections.last.split("-").map((e) => int.parse(e)).toList();

    if (_sectionOne.first >= _sectionTwo.first && _sectionOne.last <= _sectionTwo.last)
      _pairCount++; //pair 1 fits into 2
    else if (_sectionTwo.first >= _sectionOne.first && _sectionTwo.last <= _sectionOne.last)
      _pairCount++; //pair 2 fits into 1
    else if (_sectionOne.last >= _sectionTwo.first && _sectionOne.first <= _sectionTwo.last)
      _pairCount++; //pair 1 end inside pair 2
    else if (_sectionTwo.last >= _sectionOne.first && _sectionTwo.last <= _sectionOne.last) _pairCount++; // pair 2 end inside pair 1
  });
  print("Solution two: $_pairCount");
}
