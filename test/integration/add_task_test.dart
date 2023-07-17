import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/app/app.dart';

void main() {
  testWidgets('Add and delete new task smoke test',
      (WidgetTester tester) async {
    final newTaskText = 'Test Task at ${DateTime.now().toString()}';

    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Open Homepage.
    // Verify that the header and button existed.
    expect(find.text('Мои дела'), findsOneWidget);
    expect(find.text('Новое'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text(newTaskText), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that opened New task page.
    expect(find.text('СОХРАНИТЬ'), findsOneWidget);
    expect(find.text('Удалить'), findsOneWidget);

    // Type task text and submit
    await tester.enterText(find.byKey(const Key('inputBox')), newTaskText);
    await tester.pumpAndSettle();
    await tester.tap(find.text('СОХРАНИТЬ'));
    await tester.pumpAndSettle();

    // Verify that opened Homepage. Find new task by text
    expect(find.text('Мои дела'), findsOneWidget);
    expect(find.text(newTaskText), findsOneWidget);

    // open task again
    await tester.tap(find.text(newTaskText));
    await tester.pumpAndSettle();

    // Verify that opened Task page.
    expect(find.text('Удалить'), findsOneWidget);

    // Click by Delete button
    await tester.tap(find.text('Удалить'));
    await tester.pumpAndSettle();

    // Verify that opened Homepage and the task was deleted
    expect(find.text('Мои дела'), findsOneWidget);
    expect(find.text(newTaskText), findsNothing);
  });
}
