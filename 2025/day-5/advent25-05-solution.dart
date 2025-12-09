import 'dart:io';
import 'dart:math';

import '../day-2/advent25-02-solution.dart';

List<String> _input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2025/day-5/advent25-05-input.txt').readAsStringSync().split("\n\n");
}

void solutionOne() {
  final List<FreshRange> ranges = _input.first.split('\n').map(FreshRange.fromInput).toList();
  final List<int> ids = _input.last.split('\n').map(int.parse).toList();
  final List<int> freshIds = [];

  for (final id in ids) {
    for (final range in ranges) {
      if (range.isIdFresh(id)) {
        freshIds.add(id);
        break;
      }
    }
  }

  print("Solution One: ${freshIds.length}");
}



void solutionTwo() {
  final List<FreshRange> ranges = _input.first.split('\n').map(FreshRange.fromInput).toList();
  final Set<String> fresh = {};
  ranges..sort((a, b) => a.start.compareTo(b.start));


  for(int i = 0; i < ranges.length; i++){
    final a = ranges[i];
    for(int j = 0; j < ranges.length; j++){
      final b = ranges[j];
      if(i == j) continue;
    }
  }

  print(ranges);

  print("Solution Two: ${fresh.length}");
}

class FreshRange {
 int start;
 int end;

  FreshRange(this.start, this.end);

  factory FreshRange.fromInput(String input) {
    final List<int> range = input.split('-').map(int.parse).toList();
    return FreshRange(range.first, range.last);
  }

  bool isIdFresh(int id) => id >= start && id <= end;

  Set<String> get filledRange => List.generate(end + 1 - start, (i) => "${start + i}").toSet();

  @override
  String toString() {
    return "$start-$end";
  }
}
