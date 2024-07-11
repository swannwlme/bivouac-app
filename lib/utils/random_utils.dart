import 'dart:math';

String randomDocId() {
  return "${DateTime.now().millisecondsSinceEpoch}${(Random().nextInt(89) + 10).toString()}";
}