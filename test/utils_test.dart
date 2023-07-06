import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/utils/utils.dart';

void main() {
  group('Utils tests', () {
    test('uniqueId', () async {
      final id1 = uniqueId();
      final id2 = uniqueId();

      expect(id1, isNotEmpty);
      expect(id2, isNotEmpty);
      expect(id1 != id2, isTrue);
    });
  });
}
