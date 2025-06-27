import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aa_tooltip/aa_tooltip.dart';

void main() {
  group('AATooltip Tests', () {
    testWidgets('AATooltip.show creates and displays tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AATooltip.show(
                      context: context,
                      message: 'Test tooltip',
                    );
                  },
                  child: const Text('Show Tooltip'),
                );
              },
            ),
          ),
        ),
      );

      // Tap the button to show tooltip
      await tester.tap(find.text('Show Tooltip'));
      await tester.pumpAndSettle();

      // Verify tooltip is visible
      expect(AATooltip.isVisible(), isTrue);
      
      // Clean up
      AATooltip.hideAll();
      await tester.pumpAndSettle();
    });

    testWidgets('AATooltipWrapper shows tooltip on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AATooltipWrapper(
              message: 'Wrapper tooltip',
              child: const Text('Click me'),
            ),
          ),
        ),
      );

      // Tap the wrapped widget
      await tester.tap(find.text('Click me'));
      await tester.pumpAndSettle();

      // Verify tooltip is visible
      expect(AATooltip.isVisible(), isTrue);
      
      // Clean up
      AATooltip.hideAll();
      await tester.pumpAndSettle();
    });

    testWidgets('Extension tooltip method works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Icon(Icons.info).tooltip(
              message: 'Info tooltip',
            ),
          ),
        ),
      );

      // Tap the icon
      await tester.tap(find.byIcon(Icons.info));
      await tester.pumpAndSettle();

      // Verify tooltip is visible
      expect(AATooltip.isVisible(), isTrue);
      
      // Clean up
      AATooltip.hideAll();
      await tester.pumpAndSettle();
    });

    test('AATooltipConfig can be configured', () {
      const config = AATooltipConfig(
        position: AATooltipPosition.bottom,
        backgroundColor: Colors.red,
        autoHide: false,
      );

      expect(config.position, AATooltipPosition.bottom);
      expect(config.backgroundColor, Colors.red);
      expect(config.autoHide, false);
    });

    test('AATooltipConfig copyWith works correctly', () {
      const config = AATooltipConfig();
      final newConfig = config.copyWith(
        position: AATooltipPosition.left,
        backgroundColor: Colors.blue,
      );

      expect(newConfig.position, AATooltipPosition.left);
      expect(newConfig.backgroundColor, Colors.blue);
      expect(newConfig.autoHide, config.autoHide); // Should remain the same
    });
  });
}
