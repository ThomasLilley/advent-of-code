import 'dart:io';

List<String> _gamesList = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _gamesList =
      File('2022/day-2/advent22-02-input.txt').readAsStringSync().split("\n");
}

//Solution 1 Key
//A|X  == Rock     == 1
//B|Y  == Paper    == 2
//C|Z  == Scissors == 3
//Loss == 0
//Draw == 3
//Win  == 6

void solutionOne() {
  int _totalScore = 0;

  Map<String, int> _scoringTable = {
    "A X": 4,
    "A Y": 8,
    "A Z": 3,
    "B X": 1,
    "B Y": 5,
    "B Z": 9,
    "C X": 7,
    "C Y": 2,
    "C Z": 6,
  };

  _gamesList.forEach((element) {
    _totalScore += _scoringTable[element]!;
  });

  print("Solution one: $_totalScore");
}

void solutionTwo() {
  int _totalScore = 0;

//Solution two key
//A  == Rock     == 1
//B  == Paper    == 2
//C  == Scissors == 3
//X  == Lose     == 0
//Y  == Draw     == 3
//Z  == Win      == 6

  Map<String, int> _scoringTable = {
    "A X": 3, 
    "A Y": 4,
    "A Z": 8,
    "B X": 1,
    "B Y": 5,
    "B Z": 9,
    "C X": 2,
    "C Y": 6,
    "C Z": 7,
  };

  _gamesList.forEach((element) {
    _totalScore += _scoringTable[element]!;
  });

  print("Solution two: $_totalScore");
}
