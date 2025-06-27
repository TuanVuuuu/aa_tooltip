// ========================================
// SIMPLE FIX: Use GlobalKey for correct positioning
// ========================================

import 'package:flutter/material.dart';
// import 'package:aa_tooltip/aa_tooltip.dart';

class TooltipExample extends StatelessWidget {
  // Create a GlobalKey for the button
  final GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ SOLUTION 1: Use GlobalKey
            ElevatedButton(
              key: _buttonKey, // Add key to button
              onPressed: () => _showTooltipAtButton(context),
              child: const Text('Show Tooltip (Fixed Position)'),
            ),
            
            const SizedBox(height: 20),
            
            // ✅ SOLUTION 2: Use Builder (simpler)
            Builder(
              builder: (btnContext) {
                return ElevatedButton(
                  onPressed: () {
                    // AATooltip.show(
                    //   context: btnContext, // Use btnContext instead of parent context
                    //   message: 'Tooltip tại đúng vị trí!',
                    //   config: const AATooltipConfig(
                    //     autoHide: false,
                    //     backgroundColor: Colors.blue,
                    //     textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    //     position: AATooltipPosition.top,
                    //   ),
                    // );
                  },
                  child: const Text('Builder Solution'),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {}, // AATooltip.hideAll(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hide All'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTooltipAtButton(BuildContext context) {
    // Get button's RenderBox using GlobalKey
    final RenderBox? renderBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    // Get button position and size
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    
    print('Button position: $position, size: $size');

    // Use the button's context for tooltip
    // AATooltip.show(
    //   context: _buttonKey.currentContext!,
    //   message: 'Tooltip tại đúng vị trí button!',
    //   config: const AATooltipConfig(
    //     autoHide: false,
    //     backgroundColor: Colors.green,
    //     textStyle: TextStyle(color: Colors.white, fontSize: 16),
    //     position: AATooltipPosition.top,
    //   ),
    // );
  }
} 