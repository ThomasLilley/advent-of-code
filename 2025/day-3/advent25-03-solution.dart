import 'dart:io';

List<String> _input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2025/day-3/advent25-03-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  List<List<String>> batteryBanks = _input.map((e) => e.split('').toList()).toList();

  List<int> jolts = [];

  for (int bank = 0; bank < batteryBanks.length; bank++) {
    jolts.add(0);
    for (int i = 0; i < batteryBanks[bank].length - 1; i++) {
      for (int j = i + 1; j < batteryBanks[bank].length; j++) {
        final combined = int.parse('${batteryBanks[bank][i]}${batteryBanks[bank][j]}');
        if (combined > jolts[bank]) {
          jolts[bank] = combined;
        }
      }
    }
  }

  print("Solution One: $jolts \n ${jolts.reduce((a, b) => a + b)}");
}

void solutionTwo() {
  List<List<String>> batteryBanks = _input.map((e) => e.split('').toList()).toList();

  List<int> jolts = [];

  for (final bank in batteryBanks) {
    List<int> digits = List.generate(12, (_) => 0);
    int endPointer = digits.length - 1;
    int startPointer = 0;
    for (int k = 0; k < digits.length; k++) {
      for (int i = startPointer; i < (bank.length - endPointer); i++) {
        int current = int.parse(bank[i]);
        if (current > digits[k]) {
          digits[k] = current;
          startPointer = i;
        }
      }
      startPointer++;
      endPointer--;
    }
    jolts.add(int.parse(digits.join()));
  }

  print("Solution Two: $jolts \n ${jolts.reduce((a, b) => a + b)}");
}
