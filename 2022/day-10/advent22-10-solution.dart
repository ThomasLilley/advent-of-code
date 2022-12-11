import 'dart:io';

List<String> _input = [];

void main() {
  readFile();
  solution();
}

void readFile() {
  _input = File('2022/day-10/advent22-10-input.txt').readAsStringSync().split("\n");
}

void solution() {
  int x = 1;
  int _cycle = 0;
  int _crtCycle = 0;
  Map<int, int> _signals = {};
  StringBuffer buffer = StringBuffer();
  void incrementCycle(int cycles) {
    for (int i = 0; i < cycles; i++) {
      _cycle++;

      if (_cycle == 20 || (_cycle - 20) % 40 == 0) {
        _signals.addAll({_cycle: _cycle * x});
      }

      if (x == _crtCycle - 1 || x == _crtCycle || x == _crtCycle + 1) {
        buffer.write("⬜️");
      } else {
        buffer.write("⬛️");
      }

      _crtCycle++;
      if (_cycle % 40 == 0) {
        buffer.write("\n");
        _crtCycle = 0;
      }
    }
  }

  _input.forEach((element) {
    List<String> _line = element.split(" ");
    String _instruction = _line.first;
    int? _amount;
    if (_line.length > 1) _amount = int.parse(_line.last);
    switch (_instruction) {
      case "noop":
        incrementCycle(1);
        break;
      case "addx":
        incrementCycle(2);
        x += _amount!;
        break;
    }
  });

  print("Solution one: ${_signals.values.reduce((a, b) => a + b)}");
  print("Solution two:");
  print(buffer.toString());
}
