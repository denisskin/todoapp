import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/utils/device.dart';

void main() {
  group('Device tests', () {
    test('Unique Device Id test', () async {
      final id1 = await Device.getId();
      final id2 = await Device.getId();

      expect(id1, isNotEmpty);
      expect(id2, isNotEmpty);
      expect(id1 == id2, isTrue);
    });
  });
}
