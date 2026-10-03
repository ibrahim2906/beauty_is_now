import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_is_now/beauty_is_now.dart';

void main() {
  group('BeautySegmentedBar Tests', () {
    testWidgets('renders all segment labels', (WidgetTester tester) async {
      int selected = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BeautySegmentedBar.fromStrings(
              items: const ['Tab 1', 'Tab 2', 'Tab 3'],
              currentIndex: selected,
              onChanged: (index) => selected = index,
            ),
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.text('Tab 3'), findsOneWidget);

      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();
      expect(selected, 1);
    });
  });

  group('BeautyWindow Tests', () {
    testWidgets('renders title, close button and confirm button', (
      WidgetTester tester,
    ) async {
      bool confirmed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BeautyWindow(
              title: 'Test Window',
              onConfirm: () => confirmed = true,
              child: const Text('Dialog Content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Window'), findsOneWidget);
      expect(find.text('Dialog Content'), findsOneWidget);
      expect(find.byType(BeautyCloseButton), findsOneWidget);
      expect(find.byType(BeautyConfirmButton), findsOneWidget);

      await tester.tap(find.byType(BeautyConfirmButton));
      await tester.pumpAndSettle();
      expect(confirmed, true);
    });
  });

  group('BeautyNavBar Tests', () {
    testWidgets('renders all nav items and triggers onChanged', (
      WidgetTester tester,
    ) async {
      int activeIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BeautyNavBar(
              currentIndex: activeIndex,
              onChanged: (index) => activeIndex = index,
              items: const [
                BeautyNavItem(label: 'Home', icon: Icons.home),
                BeautyNavItem(label: 'Search', icon: Icons.search),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(activeIndex, 1);
    });
  });
}
