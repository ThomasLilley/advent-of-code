import 'dart:io';
import 'dart:math';

List<String> input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  input = File('2015/day-3/advent15-03-input.txt').readAsStringSync().split("");
}

void solutionOne() {
  //Santa begins by delivering a present to the house at his starting location (0,0)
  Map<Point, int> _positions = {Point(0,0): 1}; 
  int xPos = 0;
  int yPos = 0;

  for(int i = 0; i < input.length; i++){
    switch (input[i]) {
      case "^":
        yPos++;
        break;
      case ">":
        xPos++;
        break;
      case "v":
        yPos--;
        break;
      case "<":
        xPos--;
        break;
    }

    _positions.putIfAbsent(Point(xPos, yPos), () => 0);
    _positions[Point(xPos, yPos)] = _positions[Point(xPos, yPos)]! + 1;
  };
  print("Solution one: ${_positions.values.length}");
}

void solutionTwo() {
  //Santa and Robo Santa begins by delivering a present to the house at the starting location (0,0)
  Map<Point, int> _positions = {Point(0,0): 2}; 
  int xPos = 0;
  int yPos = 0;
  int xRoboPos = 0;
  int yRoboPos = 0;

  for(int i = 0; i < input.length; i++){
    switch (input[i]) {
      case "^":
        i.isEven ? yPos++ : yRoboPos++;
        break;
      case ">":
         i.isEven ? xPos++ : xRoboPos++;
        break;
      case "v":
         i.isEven ? yPos-- : yRoboPos--;
        break;
      case "<":
         i.isEven ? xPos-- : xRoboPos--;
        break;
    }

    _positions.putIfAbsent( i.isEven ? Point(xPos, yPos) : Point(xRoboPos, yRoboPos), () => 0);
    _positions[i.isEven ? Point(xPos, yPos) : Point(xRoboPos, yRoboPos)] = _positions[i.isEven ? Point(xPos, yPos) : Point(xRoboPos, yRoboPos)]! + 1;
  };
  print("Solution two: ${_positions.values.length}");
}
