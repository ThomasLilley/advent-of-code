import 'dart:io';
import 'dart:math';

List<String> _input = [];
List<int> _currentHeadPos = [0, 0];
List<int> _currentTailPos = [0, 0];
var touched = {Point(0,0)};

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-9/advent22-09-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
 

  _input.forEach((element) {
    List<String> _instruction = element.split(" ");
    String _direction = _instruction.first;
    int _length = int.parse(_instruction.last);

    for (int i = 0; i < _length; i++) {
      switch (_direction) {
        case "L":
          _currentHeadPos[0]--;
          break;
        case "R":
          _currentHeadPos[0]++;
          break;
        case "U":
          _currentHeadPos[1]++;
          break;
        case "D":
          _currentHeadPos[1]--;
          break;
      }
    
      int _xDistance = (_currentHeadPos[0] - _currentTailPos[0]);
      int _yDistance = (_currentHeadPos[1] - _currentTailPos[1]);

      if (max(_xDistance.abs(), _yDistance.abs()) > 1) {
        if (_xDistance.abs() >= 1) {
          if (_xDistance < 0) {
            _currentTailPos = [_currentTailPos[0] - 1, _currentTailPos[1]];
          } else {
            _currentTailPos = [_currentTailPos[0] + 1, _currentTailPos[1]];
          }
        }
        if (_yDistance.abs() >= 1) {
          if (_yDistance < 0) {
            _currentTailPos = [_currentTailPos[0], _currentTailPos[1] - 1];
          } else {
            _currentTailPos = [_currentTailPos[0], _currentTailPos[1] + 1];
          }
        }
      }
      touched.add(Point(_currentTailPos[0], _currentTailPos[1]));
   
    }
  });  
  print("Solution one: ${touched.length}");
}

void solutionTwo() {}

