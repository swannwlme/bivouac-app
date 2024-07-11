import 'dart:math';

String randomDocId() {
  print("Generating random doc id");
  return "${DateTime.now().millisecondsSinceEpoch}${(Random().nextInt(89) + 10).toString()}";
}