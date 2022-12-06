import 'dart:io';

List<String> _input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-5/advent22-05-input.txt').readAsStringSync().split("\n\n");
}

void solutionOne() {
  List<String> _stacks = _input.first.split("\n");
  List<String> _movements = _input.last.split("\n");
  Map<int, List<String>> _boxes = {};

//parse boxes into useable map
  for (int i = 0; i < _stacks.length - 1; i++) {
    int _count = 1;
    for (int j = 0; j < _stacks[i].length; j += 4) {
      String _box = _stacks[i].substring(j, (j + 4) > _stacks[i].length ? _stacks[i].length : j + 4).substring(1, 2);
      _boxes.putIfAbsent(_count, () => []);
      if (!_box.contains(' ')) {
        _boxes[_count]!.insert(0, _box);
      }
      _count++;
    }
  }

  ///iterate thorugh each movement and manipulate the map
  for (int i = 0; i < _movements.length; i++) {
    List<int> _instructions = _movements[i].replaceAll(RegExp(r'(move )|(from )|(to )'), '').split(' ').map((e) => e.trim()).toList().map((e) => int.parse(e)).toList();

    for (int boxCount = 0; boxCount < _instructions.first; boxCount++) {
      String _boxToMove = _boxes[_instructions[1]]!.removeLast();
      _boxes[_instructions[2]]!.add(_boxToMove);
    }
  }

  ///build output from top of each stack
  String _output = "";
  _boxes.forEach((key, value) => _output += value.last);

  print("Solution one: $_output");
}

void solutionTwo() {
  List<String> _stacks = _input.first.split("\n");
  List<String> _movements = _input.last.split("\n");
  Map<int, List<String>> _boxes = {};

//parse boxes into useable map
  for (int i = 0; i < _stacks.length - 1; i++) {
    int _count = 1;
    for (int j = 0; j < _stacks[i].length; j += 4) {
      String _box = _stacks[i].substring(j, (j + 4) > _stacks[i].length ? _stacks[i].length : j + 4).substring(1, 2);
      _boxes.putIfAbsent(_count, () => []);
      if (!_box.contains(' ')) {
        _boxes[_count]!.insert(0, _box);
      }
      _count++;
    }
  }

  ///iterate thorugh each movement and manipulate the map
  for (int i = 0; i < _movements.length; i++) {
    List<int> _instructions = _movements[i].replaceAll(RegExp(r'(move )|(from )|(to )'), '').split(' ').map((e) => e.trim()).toList().map((e) => int.parse(e)).toList();
    List<String> _boxesToMove = [];
    for (int boxCount = 0; boxCount < _instructions.first; boxCount++) {
      _boxesToMove.insert(0, _boxes[_instructions[1]]!.removeLast());
    }
    _boxes[_instructions[2]]!.addAll(_boxesToMove);
  }

  ///build output from top of each stack
  String _output = "";
  _boxes.forEach((key, value) => _output += value.last);

  print("Solution two: $_output");
}
