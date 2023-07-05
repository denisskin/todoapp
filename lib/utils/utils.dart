import 'dart:math';

String uniqueId() {
  final seed = DateTime.now().microsecondsSinceEpoch;
  return Random(seed).nextInt(0xffffff).toRadixString(16);
}

DateTime? unixToDatetime(int v) {
  if (v <= 0) return null;
  return DateTime.fromMillisecondsSinceEpoch(v * 1000, isUtc: true);
}

int toUnix(DateTime? d) {
  return (d?.toUtc().millisecondsSinceEpoch ?? 0) ~/ 1000;
}
