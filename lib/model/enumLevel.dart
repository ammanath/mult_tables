import 'package:flutter/foundation.dart';
import 'package:mult_tables/model/mult__icons_icons.dart';

enum Level { Easy, Medium, Difficult }

enum OpType { Add, Subtract, Multiply, Divide }

extension ParseToString on OpType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

extension ParseToSymbol on OpType {
  String toOpSymbol() {
    switch (describeEnum(this)) {
      case 'Add':
        return '+';
        break;
      case 'Subtract':
        return '-';
        break;
      case 'Multiply':
        return '*';
        break;
      case 'Divide':
        return '/';
        break;
      default:
        return '~';
    }
  }
}
