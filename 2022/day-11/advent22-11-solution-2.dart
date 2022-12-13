import 'dart:io';

List<String> _input = [];
List<Monkey> _monkeys = [];
bool _printDebug = false;

void main() {
  readFile();
  print("Solution one: ${solution(20)}");
}

void readFile() {
  _input = File('2022/day-11/advent22-11-input.txt').readAsStringSync().split("\n\n");
}

void debugPrint(dynamic s) {
  if (_printDebug) print(s);
}

int solution(int rounds) {
  _monkeys = [];
  _input.forEach((element) {
    List<String> _lines = element.split("\n");
    int _number = int.parse(_lines[0].substring(_lines[0].length - 2, _lines[0].length - 1));
    List<MonkeyItem> _items = _lines[1].replaceRange(0, 18, "").split(", ").map((e) => MonkeyItem(int.parse(e), [])).toList();
    String _operation = _lines[2].replaceRange(0, 19, "");
    int _test = int.parse(_lines[3].substring(_lines[3].length - 2, _lines[3].length).trim());
    int _trueCase = int.parse(_lines[4].substring(_lines[4].length - 1, _lines[4].length));
    int _falseCase = int.parse(_lines[5].substring(_lines[5].length - 1, _lines[5].length));
    _monkeys.add(Monkey(
      _number,
      _items,
      _operation,
      _test,
      _trueCase,
      _falseCase,
    ));
  });

  List<int> tests = [];
  _monkeys.forEach((monkey) => tests.add(monkey.test));
  _monkeys.forEach((monkey) {
    monkey.items.forEach((item) {
      item.createMonkeyWorryValues(tests);
    });
  });
  for (int round = 0; round < rounds; round++) {
    for (int i = 0; i < _monkeys.length; i++) {
      _monkeys[i].completeTurn(tests);
      _monkeys[i].items.forEach((item) {
        if (_monkeys[i].testValue(i, item))
          _monkeys[_monkeys[i].trueCase].items.add(item);
        else
          _monkeys[_monkeys[i].falseCase].items.add(item);
      });
      _monkeys[i].items.clear();
    }
  }

  List<int> _finalInspectionLevels = _monkeys.map((e) => e._itemsInspected).toList();
  _finalInspectionLevels.sort(((a, b) => b.compareTo(a)));

  return _finalInspectionLevels[0] * _finalInspectionLevels[1];
}

class Monkey {
  int number;
  List<MonkeyItem> items;
  String operation;
  int test;
  int trueCase;
  int falseCase;
  int _itemsInspected = 0;
  Monkey(
    this.number,
    this.items,
    this.operation,
    this.test,
    this.trueCase,
    this.falseCase,
  );

  void completeTurn(List<int> tests) {
    debugPrint("Monkey $number:");
    for (int i = 0; i < items.length; i++) {
      for (int j = 0; j < items[i].monkeyValues.length; j++) {
        debugPrint(" Monkey inspects and item with a worry level of ${items[i]}");
        List<String> _operations = operation.split(" ");
        switch (_operations[1]) {
          case "*":
            items[i].monkeyValues[j] = (items[i].monkeyValues[j] * (_operations[2].startsWith("old") ? items[i].monkeyValues[j] : int.parse(_operations[2]) % tests[j])) % tests[j];
            break;
          case "+":
            items[i].monkeyValues[j] = (items[i].monkeyValues[j] + (int.parse(_operations[2]) % tests[j])) % tests[j];
        }
      }
      _itemsInspected++;
    }
    debugPrint("\n");
  }

  bool testValue(int index, MonkeyItem item) {
    return item.monkeyValues[index] == 0;
  }

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    // buffer.writeln("\nMonkey:");
    // buffer.writeln("number: $number");
    // buffer.writeln("items: $items");
    // buffer.writeln("operation: $operation");
    // buffer.writeln("test: $test");
    // buffer.writeln("true: $trueCase");
    // buffer.writeln("false: $falseCase");
    buffer.writeln("Monkey $number Inspected: $_itemsInspected");
    buffer.writeln("Monkey $number Items: $items");
    return buffer.toString();
  }
}

class MonkeyItem {
  int initialValue;
  List<int> monkeyValues;
  MonkeyItem(this.initialValue, this.monkeyValues);

  void createMonkeyWorryValues(List<int> tests) {
    tests.forEach((test) => this.monkeyValues.add(this.initialValue % test));
  }

  @override
  String toString() {
    return 'init:$initialValue values:$monkeyValues';
  }
}
