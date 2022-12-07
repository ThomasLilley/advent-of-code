import 'dart:io';

List<String> _input = [];
TreeNode<String>? _filesystem;
TreeNode<String>? _currentNode;

class TreeNode<T> {
  TreeNode<T>? parent;
  T value;
  List<TreeNode<T>>? children;
  List<ElfFile>? files;
  TreeNode(this.value, {this.parent, this.children, this.files});

  void add(TreeNode<T> child) {
    children ??= [];
    if (!children!.contains(child)) {
      children!.add(child);
    }
  }

  void addFile(ElfFile file) {
    files ??= [];
    files!.add(file);
  }

  void printTree() {
    int level = 0;
    String _tabs = "";

    TreeNode element = this;
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

  @override
  bool operator ==(o) => o is TreeNode && value == o.value;
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return "$value (dir)";
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
  _input = File('2022/day-7/advent22-07-example.txt').readAsStringSync().split("\n");
}

void solutionOne() {
  for (int i = 0; i < _input.length; i++) {
    if (_input[i].startsWith("\$")) {
      if (_input[i] == "\$ cd /") {
        _currentNode = _filesystem = TreeNode("/");
      } else if (_input[i].startsWith("\$ cd")) {
        if (_input[i] == "\$ cd ..") {
          _currentNode = _currentNode?.parent;
        } else {
          String _dir = _input[i].replaceAll("\$ cd ", "");
          TreeNode<String> _newNode = TreeNode<String>(_dir, parent: _currentNode);
          _currentNode?.add(_newNode);
          _currentNode = _currentNode?.children?.firstWhere((element) => element == _newNode);
        }
      }
    } else if (_input[i].startsWith("dir")) {
      String _dir = _input[i].replaceAll("dir ", "");
      _currentNode?.add(TreeNode<String>(_dir, parent: _currentNode));
    } else {
      _currentNode?.addFile(ElfFile.fromString(_input[i]));
    }
  }
  _filesystem?.printTree();
}

///add first level to map
///access first level
///add next level to map
///repeat until bottom

void solutionTwo() {}
