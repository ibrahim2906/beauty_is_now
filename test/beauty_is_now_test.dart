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

    testWidgets('grows while dragging the pill and shrinks on release', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 320,
                child: BeautySegmentedBar.fromStrings(
                  items: const ['Tab 1', 'Tab 2', 'Tab 3'],
                  currentIndex: 0,
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(BeautySegmentedBar)),
      );
      await gesture.moveBy(const Offset(40, 0));
      await tester.pump(const Duration(milliseconds: 300));

      expect(
        tester
            .widgetList<AnimatedScale>(find.byType(AnimatedScale))
            .first
            .scale,
        1.03,
      );

      await gesture.up();
      await tester.pumpAndSettle();

      expect(
        tester
            .widgetList<AnimatedScale>(find.byType(AnimatedScale))
            .first
            .scale,
        1.0,
      );
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

    testWidgets('grows while dragging the pill and shrinks on release', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 320,
                child: BeautyNavBar(
                  currentIndex: 0,
                  onChanged: (_) {},
                  items: const [
                    BeautyNavItem(label: 'Home', icon: Icons.home),
                    BeautyNavItem(label: 'Search', icon: Icons.search),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(BeautyNavBar)),
      );
      await gesture.moveBy(const Offset(40, 0));
      await tester.pump(const Duration(milliseconds: 300));

      expect(
        tester
            .widgetList<AnimatedScale>(find.byType(AnimatedScale))
            .first
            .scale,
        1.03,
      );

      await gesture.up();
      await tester.pumpAndSettle();

      expect(
        tester
            .widgetList<AnimatedScale>(find.byType(AnimatedScale))
            .first
            .scale,
        1.0,
      );
    });
  });
}
