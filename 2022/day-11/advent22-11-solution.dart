import 'dart:io';

List<String> _input = [];
List<Monkey> _monkeys = [];
bool _printDebug = false;
bool _divideFear = true;

void main() {
  readFile();
  _divideFear = true;
  print("Solution one: ${solution(20)}");

  _divideFear = false;
  print("Solution two: ${solution(1000)}");
  
}

void readFile() {
  _input = File('2022/day-11/advent22-11-input.txt').readAsStringSync().split("\n\n");
}

void debugPrint(String s){
  if(_printDebug) print(s);
}

int solution(int rounds,) {
  _monkeys = [];
  _input.forEach((element) {
    List<String> _lines = element.split("\n");
    int _number = int.parse(_lines[0].substring(_lines[0].length - 2, _lines[0].length - 1));
    List<int> _items = _lines[1].replaceRange(0, 18, "").split(", ").map((e) => int.parse(e)).toList();
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

  for (int i = 0; i < rounds; i++) {
    for (int monkey = 0; monkey < _monkeys.length; monkey++) {
      _monkeys[monkey].completeTurn((throwMonkey, item) {
        _monkeys[throwMonkey].items.add(item);
      });
    }
  }

  List<int> _finalInspectionLevels = _monkeys.map((e) => e._itemsInspected).toList();
  _finalInspectionLevels.sort(((a, b) => b.compareTo(a)));

  return _finalInspectionLevels[0] * _finalInspectionLevels[1];
}

class Monkey {
  int number;
  List<int> items;
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

  void completeTurn(Function(int throwMonkey, int item) callback) {
    debugPrint("Monkey $number:");
    for (int i = 0; i < items.length; i++) {
      debugPrint(" Monkey ispects and item with a worry level of ${items[i]}");
      items[i] = _inspectItem(items[i]);
      _itemsInspected++;
      if(_divideFear) items[i] = (items[i] / 3).floor();
      debugPrint("  Monkey gets bored with item. Worry level is divided by 3 to ${items[i]}.");
      int _monkey = _testItem(items[i]);
      callback(_monkey, items[i]);
    }
    debugPrint("\n");
    items = [];
  }

  int _inspectItem(int i) {
    List<String> _operations = operation.split(" ");
    switch (_operations[1]) {
      case "*":
        if (_operations[2].startsWith("old")) {
          debugPrint("  Worry level is multiplied by $i to ${i * i}");
          return i * i;
        } else {
          debugPrint("  Worry level is multiplied by ${int.parse(_operations[2])} to ${i * int.parse(_operations[2])}");
          return i * int.parse(_operations[2]);
        }
      case "+":
        if (_operations[2].startsWith("old")) {
          debugPrint("  Worry level is increased by $i to ${i + i}");
          return i + i;
        } else {
          debugPrint("  Worry level is increased by ${int.parse(_operations[2])} to ${i + int.parse(_operations[2])}");
          return i + int.parse(_operations[2]);
        }
    }
    return 0;
  }

  int _testItem(int item) {
    if (item % test == 0) {
      debugPrint("  worry level is divisible by $test.");
      debugPrint("  item with worry level $item is thrown to monkey $trueCase");
      return trueCase;
    }
    debugPrint("  worry level is not divisible by $test.");
    debugPrint("  item with worry level $item is thrown to monkey $falseCase");
    return falseCase;
  }

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    buffer.writeln("\nMonkey:");
    buffer.writeln("number: $number");
    buffer.writeln("items: $items");
    buffer.writeln("operation: $operation");
    buffer.writeln("test: $test");
    buffer.writeln("true: $trueCase");
    buffer.writeln("false: $falseCase");
    buffer.writeln("items Inspected: $_itemsInspected");
    return buffer.toString();
  }
}
