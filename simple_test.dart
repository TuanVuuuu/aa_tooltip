import 'package:flutter/material.dart';
// import 'package:aa_tooltip/aa_tooltip.dart'; // Uncomment this line

class SimpleTooltipTest extends StatelessWidget {
  const SimpleTooltipTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // AATooltip.show(
            //   context: context,
            //   message: 'Test tooltip!',
            //   config: const AATooltipConfig(
            //     autoHide: false,
            //     backgroundColor: Colors.black87,
            //     textStyle: TextStyle(color: Colors.white, fontSize: 16),
            //   ),
            // );
          },
          child: const Text('Test Tooltip'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // AATooltip.hideAll();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Hide All'),
        ),
      ],
    );
  }
} 