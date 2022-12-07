import 'dart:io';

List<String> _input = [];
Directory<String>? _filesystem;
Directory<String>? _currentNode;

class Directory<T> {
  Directory<T>? parent;
  T value;
  List<Directory<T>>? children;
  List<ElfFile>? files;
  Directory(this.value, {this.parent, this.children, this.files});

  void add(Directory<T> child) {
    children ??= [];
    if (!children!.contains(child)) {
      children!.add(child);
    }
  }

  void addFile(ElfFile file) {
    files ??= [];
    files!.add(file);
  }

  int getDirectorySize() {
    int size = 0;
    if(files != null)files!.forEach((element) => size += element.size);
    if(children!=null)children!.forEach((element) => size+= element.getDirectorySize());
    return size;
  }

  void printTree() {
    int level = 0;
    String _tabs = "";

    Directory element = this;
    while (element.parent != null) {
      element = element.parent!;
      level++;
    }

    for (int i = 0; i < level; i++) {
      _tabs += "  ";
    }
    if (_tabs.isNotEmpty) _tabs += "-";
    level++;

    print(_tabs + this.toString());
    children?.forEach((element) => element.printTree());
    files?.forEach((e) => print("  ${_tabs}$e "));
  }

  int sumDirectories(int ofSize){
    int size = 0;
    int _temp = getDirectorySize();
    if(_temp <= ofSize) size += _temp;
     children?.forEach((element) => size += element.sumDirectories(ofSize));
    return size;
  }

  @override
  bool operator ==(o) => o is Directory && value == o.value;
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return "$value (dir, size=${getDirectorySize()})";
  }
}

class ElfFile {
  String name;
  int size;
  ElfFile(this.name, this.size);

  factory ElfFile.fromString(String string) {
    List<String> _parts = string.split(" ");
    return ElfFile(_parts.last, int.parse(_parts.first));
  }

  @override
  String toString() {
    return "$name (file, size=$size)";
  }
}

void main() {
  readFile();
  solutionOne();
  solutionTwo();
}

void readFile() {
  _input = File('2022/day-7/advent22-07-input.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  for (int i = 0; i < _input.length; i++) {
    if (_input[i].startsWith("\$")) {
      if (_input[i] == "\$ cd /") {
        _currentNode = _filesystem = Directory("/");
      } else if (_input[i].startsWith("\$ cd")) {
        if (_input[i] == "\$ cd ..") {
          _currentNode = _currentNode?.parent;
        } else {
          String _dir = _input[i].replaceAll("\$ cd ", "");
          Directory<String> _newNode = Directory<String>(_dir, parent: _currentNode);
          _currentNode?.add(_newNode);
          _currentNode = _currentNode?.children?.firstWhere((element) => element == _newNode);
        }
      }
    } else if (_input[i].startsWith("dir")) {
      String _dir = _input[i].replaceAll("dir ", "");
      _currentNode?.add(Directory<String>(_dir, parent: _currentNode));
    } else {
      _currentNode?.addFile(ElfFile.fromString(_input[i]));
    }
  }
  _filesystem?.printTree();
  print("Solution one: ${_filesystem?.sumDirectories(100000)}");
}


void solutionTwo() {}
