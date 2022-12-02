import 'dart:io';

List<String> input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  input =
      File('2015/day-2/advent15-02-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  int feet = 0;
  input.forEach((element) {
    List<String> _box = element.split("x");
    List<int> _boxDimensions = [];
    _box.forEach((element) {
      _boxDimensions.add(int.parse(element));
    });
    _boxDimensions.sort();

    feet += (_boxDimensions[0] * _boxDimensions[1]); //slack
    feet += 2 * (_boxDimensions[0] * _boxDimensions[1]); //smallest side
    feet += 2 * (_boxDimensions[0] * _boxDimensions[2]); //another side
    feet += 2 * (_boxDimensions[1] * _boxDimensions[2]); //longest side
  });
  print("Solution one: $feet");
  
}

void solutionTwo() {
 int feet = 0;
  input.forEach((element) {
    List<String> _box = element.split("x");
    List<int> _boxDimensions = [];
    _box.forEach((element) {
      _boxDimensions.add(int.parse(element));
    });
    _boxDimensions.sort();

    feet += (_boxDimensions[0] +_boxDimensions[0] + _boxDimensions[1] + _boxDimensions[1]); //ribbon length
    feet += (_boxDimensions[0] * _boxDimensions[1] * _boxDimensions[2]); //bow size
  });
  print("Solution two: $feet");
}
