import 'dart:convert';
import 'package:crypto/crypto.dart';

String input = "yzbqklnj";

void main() {
  print("Solution one: ${solution("00000")}");
  print("Solution two: ${solution("000000")}");
}

String solution(String _pattern) {
  int _counter = 1;
  while (true) {
    String _md5 = md5.convert(utf8.encode("$input$_counter")).toString();
    if (_md5.startsWith(_pattern)) {
      return("$input$_counter = $_md5");
    }
    _counter++;
  }
}
