enum Level { Easy, Medium, Difficult }

enum OpType { Add, Subtract, Multiply, Divide }

extension ParseToString on OpType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

