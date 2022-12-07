import 'dart:io';

List<String> _input = [];

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-6/advent22-06-input.txt').readAsStringSync().split("");
}

void solutionOne() {
for(int i = 0; i<_input.length; i++){
if(i+4 > _input.length) break;
List<String> _window = _input.getRange(i, i+4).toList();
Set _unique = _window.toSet();
if(_unique.length == _window.length){
  print("Solution one: ${_window.join()} at ${i+4}");
  break;
};
}
}

void solutionTwo() {
for(int i = 0; i<_input.length; i++){
if(i+14 > _input.length) break;
List<String> _window = _input.getRange(i, i+14).toList();
Set _unique = _window.toSet();
if(_unique.length == _window.length){
  print("Solution two: ${_window.join()} at ${i+14}");
  break;
};
}
}
