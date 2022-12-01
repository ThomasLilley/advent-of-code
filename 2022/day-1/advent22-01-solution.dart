import 'dart:io';

List<dynamic> _calorieList = [];
List<int> _calorieTotals = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _calorieList =
      File('2022/day-1/advent22-01-input.txt').readAsStringSync().split("\n\n");
}

void solutionOne() {
  _calorieList.forEach((elfCalories) {
    List<String> _splitElfCalories = elfCalories.split("\n");
    int _addedElfCalories = 0;
    _splitElfCalories.forEach((calorie) {
      int? _calorie = int.parse(calorie);
      _addedElfCalories += _calorie;
    });
    _calorieTotals.add(_addedElfCalories);
  });

  _calorieTotals.sort((a, b) => b.compareTo(a));
  print("Solution one: ${_calorieTotals[0]}");
}

void solutionTwo() {
  print(
      "Solution two: ${_calorieTotals[0] + _calorieTotals[1] + _calorieTotals[2]}");
}
