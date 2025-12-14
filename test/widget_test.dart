// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

mixin Swimmer {
  void swim() {
    print("Swimming...");
  }
}

class Human with Swimmer {}

class Fish with Swimmer {}

class Bird {}

void main() {
  final human = Human();
  final fish = Fish();
  final bird = Bird();

  expect(human is Swimmer, true); // true
  expect(fish is Swimmer, true); // true
  expect(bird is Swimmer, false); // false
}
